Cabability Regression
======================

# No capability
Everything should work

# Using capability.env

"moodle/config/capability-moodle-settings.scsv"
'${GUEST}';'${CAPABILITY}';'${OPERATION}';${FLAG}

"envs/theme\_fordson.env"
GUEST=3
CAPABILITY="moodle/site:approvecourse"
OPERATION="prevent"
FLAG=1

FRONTPAGE="frontpage"
CAPABILITY="moodle/site:approvecourse"
OPERATION="allow"
FLAG=1

"capability.env"
EVERY\_MOODLE\_PHP\_CAPABILITY="moodle-settings.scsv"
