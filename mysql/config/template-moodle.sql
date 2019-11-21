INSERT IGNORE INTO mdl_role_allow_assign SET roleid = (SELECT id FROM mdl_role WHERE shortname= 'manager'), allowassign = (SELECT id FROM mdl_role WHERE shortname= 'editingstudent');
INSERT IGNORE INTO mdl_role_allow_assign SET roleid = (SELECT id FROM mdl_role WHERE shortname= 'coursecreator'), allowassign = (SELECT id FROM mdl_role WHERE shortname= 'editingstudent');
INSERT IGNORE INTO mdl_role_allow_assign SET roleid = (SELECT id FROM mdl_role WHERE shortname= 'editingteacher'), allowassign = (SELECT id FROM mdl_role WHERE shortname= 'editingstudent');
INSERT IGNORE INTO mdl_role_allow_assign SET roleid = (SELECT id FROM mdl_role WHERE shortname= 'teacher'), allowassign = (SELECT id FROM mdl_role WHERE shortname= 'editingstudent');
