# create a dataset
# TODO: create -c hirni?
datalad create -c hirni DTA
cd DTA

# installing the necessary code into the dataset
datalad install -d . -s git@github.com:TobiasKadelka/build_dta.git code/build_dta

# modify the rules for the spec, so the dta-rules will be used
git config -f .datalad/config datalad.hirni.dicom2spec.rules code/build_dta/code/create/dta_dicom2spec_rules.py


# get the source_data for DTA1 # TODO: put tars into separate folder outside of dataset
#mkdir -p code/tmp/
#python code/build_dta/code/scripts/tar_DTA1.py $(pwd) > code/tmp/tar_DTA1.sh # relative paths in tar_DTA.sh-scripts
#chmod 775 code/tmp/tar_DTA1.sh
# here the tar commands are happening ( one tar per acquisition -> session with T1, task-rest, etc)
#./code/tmp/tar_DTA1.sh

# source_data for DTA2
#python code/build_dta/code/scripts/tar_DTA2.py $(pwd) > code/tmp/tar_DTA2.sh
#chmod 775 code/tmp/tar_DTA2.sh
#./code/tmp/tar_DTA2.sh

# hirni-import-dcm
#chmod 775 ./code/build_dta/code/scripts/hirni-import-dcm.sh
./code/build_dta/code/scripts/hirni-import-dcm.sh

# hirni-dicom2spec # hirni-import macht das eh, im Buildscript weg, code daneben in einen Ordner legen
#chmod 775 code/build_dta/code/scripts/run_dicom2spec.sh
./code/build_dta/code/scripts/run_dicom2spec.sh

# hirni-spec2bids
#chmod 775 code/build_dta/code/scripts/run_spec2bids.sh
#./code/build_dta/code/scripts/run_spec2bids.sh

# procedures for correcting names
for d in ./T* ; do
	code/build_dta/code/scripts/rename_fieldmaps_files.py $d/studyspec.json
done

# drei Befhele aus der Demo hier hin zum pürüfen

