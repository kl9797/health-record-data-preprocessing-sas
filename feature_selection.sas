libname pro "/scratch/yf31/uhc/process";
libname uhc "/scratch/yf31/uhc";

data pro.betablocker_filter;
set pro.betablocker_t_c;
where DIAG in ('V86', '961', '265', '100', '672', '023', '712', '175', '484', '045', '804', '031', '962', '974', '144', '164', '394', '668', '513', '699', '452', '830', '494', '985', '871', '413', '411', '445', '414', '404', '230', '225', '171', '012', '412', '963', '427', '402', '551', '424', '346', '297', '398', '226', '889', 'E93', '040', '437', '435', '338', '206', '363', '429', '410', '396', '252', '182', '366', '433', '450', '426', '136', '374', '333', '441', '039', 'V42', '432', '161', '242', 'E87', '888', '434', '223', '894', '901', '964', 'V45', '457', 'V43', '189', '440', '306', '458', '018', '516', '517', '268', '401', '428', '356', '585', '852', '875', '362', '377', '332', '446', '515', '361', '281', 'E94', '386', '785', '274', '476', 'V80', '730', '583', '514', '588', '702', '571', '083', '403', '997', '021', '236', '379', '425', '224', '444', '416', '266', '753', '365', '405', '431', '442', '982', '820', '822', 'V10', '357', '618', '533', '582', 'V58', '447', '173', '375', 'V12', '272', '707', '586', '491', '395', '596', '733', '436', '996', '337', '485', '327', '443', '715', '703', '600', '271', '451', '423', '185', '397', '794', '593', '584', '710', '697', '269', '287', '721', '250', '562', '750', 'V19', '725', '090', '285', '188', '598', '420', '821', '927', '251', '157', '601', '579', '973', '553', '453', '943', '511', '241', '738', '790', '470', '781', '293', '286', '270', '876', '232', '210', 'V53', '229', '276', '714', '595', '376', '393', '370', '421', '972', '826', '355', '368', '573', '459', '578', '151', '174', '279', '681', '369', '627', '799', '259', '240', '213', '716', 'V14', '257', '670', '496', '784', '088', '155', '198', '335', '159', '833', '977', '237', '196', '530', '244', '751', '695', 'V49', 'V64', '564', '138', '456', '518', '422', '202', '245', '211', '576', '110', '610', '482', '998', '246', '454', '222', '722', '597', '793', '235', 'V99', '786', '280', '577', '746', '228', '183', '277', '735', '529', '407', '239', '038', '812', '999', '373', '156', '675', '836', '825', '238', '430', '729', '892', '568', '726', '348', '592', '200', '150', '275', '701', '787', '053', '310', '438', '798', '536', '599', '170', 'V67', '121');
run;

%macro DummyVars(DSIn,
                 VarList,
                 DSOut);

  data uhc.AddFakeY / view=uhc.AddFakeY;
  set &DSIn;
  _Y = 0;
  run;

  proc glmselect data=uhc.AddFakeY NOPRINT outdesign(addinputvars)=&DSOut(drop=_Y);
  class  &VarList;
  model _Y = &VarList /  noint selection=none;
  run;
%mend;

%DummyVars(pro.betablocker_filter, DIAG, pro.betablocker_dummy);

libname pro "/scratch/yf31/uhc/process";

proc contents varnum data = pro.betablocker_dummy;
ods select position;
run;

ods graphics on;
proc glmselect data=pro.betablocker_dummy plots=all;
model treatment = DIAG_012 -- DIAG_V86 max_1 -- max_8 yrdob/ details=all stats=all;
run;
ods graphics off;
~                   
