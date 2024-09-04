# key-creator
Create ssh keys to use for GitHub deploy keys  
This project is largely written with the help of ChatGPT

## Usage

Save to file (key-creator.sh) then run `sudo chmod +x key-creator.sh` to make exectuable  
I personally recommend just copying the contents of the file in this repo and saving that to a file instead of cloning this entire repo

The script takes 2 arguments, one for the unique identifier for the key (required by github deploy keys) and one email argument  
`./create-deploy-key.sh <uniqueIdentifier> <email>`  
ex: `./create-deploy-key.sh KC myemail@gmail.com`

To clone repository after adding key use: `git clone git@uniqueIdentifier:GitHubUsername/GithubRepoName`  
ex for this repo and the unique identifier "KC": `git clone git@KC:antudic/key-creator`
