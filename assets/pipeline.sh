#!/bin/bash
# Pipeline

# Subrotine to handle errors
function handle_error {
    if [ $? -ne 0 ] # Check if previous command status code is not 0
    then
        echo 'pipeline -> fail ->' $1 # Outout an error message
        exit 1 # Exit pipeline with status 1
    fi
}

# Update modules
# npm install

# Static verification test
python3 test-comments.py
handle_error 'python3 test-comments.py'
echo 'pipeline -> pass -> Comments check in all .ts files test successful!'

# Build and Run application
npm run build
handle_error 'npm run build'
echo 'pipeline -> pass -> Application build successful!'

# TODO: Perform Jest tests

if [ -z "$1" ] # If no commit message was supplied, don't deploy
then
    echo 'pipeline -> info -> No commit message supplied, not deploying!'
    exit 0
fi

# Add and commit changes to version control
COMMIT_PATTERN="^[0-9]+(\.[0-9]+)*\s(Add|Update|Fix)\s.+$"
if [[ $1 =~ $COMMIT_PATTERN ]]
then
    cd ../
    VERSION=$(echo $1 | grep -oP '^[0-9]+(\.[0-9]+)*')
    echo 'pipeline -> info -> Preparing to deploy version ' $VERSION ' ...'
    echo 'pipeline -> info -> Adding files...'
    git add .
    echo 'pipeline -> info -> Commiting changes...'
    git commit -m "COMPX341-21A-V ${1}"
    handle_error 'git commit -m $1'
    echo 'pipeline -> info -> Deploying...'
    git push origin master
    handle_error 'git push origin master'

    echo 'pipeline -> pass -> Deployment completed successfully!'
else
    echo 'pipeline -> fail -> Commit message does not adhere to project convention: <version> Add|Update|Fix <change>'
    exit 1
fi