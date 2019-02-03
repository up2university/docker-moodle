<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Autoload the libraries
 * 20 Dec 2018
 * Michelle Bachler, KMi, The Open University
 */

define('CLI_SCRIPT', true);
require(__DIR__ . '/../../config.php');

$h5pcore = \mod_hvp\framework::instance('core');
$interface = \mod_hvp\framework::instance('interface');

autoInstallLibraries();

function autoInstallLibraries() {
	global $DB, $h5pcore;

	// Fetch the libraries to install - only those that are for a version of hvp less than or equal to the current version
	$apiMajorVersion = $h5pcore::$coreApi['majorVersion'];
	$apiMinorVersion = $h5pcore::$coreApi['minorVersion'];

	$sql = "SELECT * FROM {hvp_libraries_hub_cache} WHERE h5p_major_version <= ? AND h5p_minor_version <= ?";
	$libraries = $DB->get_records_sql($sql, array($apiMajorVersion, $apiMinorVersion));

	foreach ($libraries as $next) {
		$machinename = $next->machine_name;
		libraryInstall($machinename);
	}
}

/**
* Handles installation of libraries from the Content Type Hub.
*
* Accepts a machine name and attempts to fetch and install it from the Hub.
* Will also install any dependencies to the requested library.
*
* @param string $machineName Name of library that should be installed
*/
function libraryInstall($machineName) {
	global $interface, $h5pcore;

	// Override the permissions to allow it to install the libraries
	$h5pcore->mayUpdateLibraries(TRUE);

	// Retrieve content type from hub endpoint - get zip file and upack
	$response = callHubEndpoint(H5PHubEndpoints::CONTENT_TYPES . $machineName);
	if (!$response) return;

	// Check the library package is valid - Needs mayUpdateLibraries(TRUE) set above as part of it's checking
	if (!isValidPackage(TRUE)) return;

	// Save library
	$storage = new H5PStorage($interface, $h5pcore);
	$storage->savePackage(NULL, NULL, TRUE);

	// Clean up downloaded folder of files for library
	removeTemporarilySavedFiles($interface->getUploadedH5pFolderPath());
}

/**
* Calls provided hub endpoint and downloads the response to a .h5p file.
*
* @param string $endpoint Endpoint without protocol
*
* @return bool
*/
function callHubEndpoint($endpoint) {
	global $interface;

	$path = $interface->getUploadedH5pPath();
	$response = $interface->fetchExternalData(H5PHubEndpoints::createURL($endpoint), NULL, TRUE, empty($path) ? TRUE : $path);
	if (!$response) {
	  return FALSE;
	}

	return TRUE;
}

/**
* Validates the package.
*
* @param bool $skipContent Will not validate cotent if set to TRUE
*
* @return bool
*/
function isValidPackage($skipContent = FALSE) {
	global $interface, $h5pcore;

	$validator = new H5PValidator($interface, $h5pcore);
	if (!$validator->isValidPackage($skipContent, FALSE)) {
	  return FALSE;
	}

	return TRUE;
}

/**
 * Clean up temporary files
 *
 * @param string $filePath Path to file or directory
 */
function removeTemporarilySavedFiles($filePath) {
	global $h5pcore;

	if (is_dir($filePath)) {
		$h5pcore::deleteFileTree($filePath);
	}
	else {
		@unlink($filePath);
	}
}