#!/bin/bash
export AWS_ACCOUNT_ID="654654216424"
export AWS_DEFAULT_REGION="eu-west-1"
export CBR__CUSTOM__PATH_CUSTOM_CODE="$PWD/custom"
export CBR__CUSTOM__PACKAGES_TO_INSTALL='["cbr_website_beta", "cbr_static", "cbr_content", "cbr_web_components"]'
export S3_DEV__BUCKET="654654216424--cbr-deploy--eu-west-1"
export S3_DEV__PARENT_FOLDER="cbr-custom-websites"
export S3_DEV__VERSION='dev__custom-version__cbr_community'
export CBR__CUSTOM__VERSION_FILE=$S3_DEV__VERSION
export CBR__CUSTOM__LAMBDA_NAME="dev__custom-version__cbr_community"
export PYTHONPATH=/tmp
export cbr_website_beta=/usr/local/lib/python3.12/site-packages/cbr_website_beta/
export cbr_static=/usr/local/lib/python3.12/site-packages/cbr_static/

echo "****** UPDATING S3 and deploying to Lambda (with current custom code) ******"



python__publish_to_s3=${cbr_website_beta}/utils/update_from_s3/CBR__Publish_To_S3__Custom_Version.py
python__create_lambda=${cbr_website_beta}/utils/update_from_s3/CBR__Custom__Deploy_Lambda.py
python__download_and_run=${cbr_website_beta}/utils/update_from_s3/Release_Package__via__S3.py

echo "****** RUN Deploy to S3 and Lambda ******"
python $python__publish_to_s3
python $python__create_lambda
echo "****** RUN Custom Version locally ******"
cbr_website_beta=/usr/local/lib/python3.12/site-packages/cbr_website_beta/

python $python__download_and_run

# make the custom files unziped in the /tmp folder the main Python packages
export PYTHONPATH=/tmp

python -m cbr_website_beta
