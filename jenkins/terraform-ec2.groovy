properties([
    parameters([
        choice(choices: ['dev', 'qa', 'prod'], description: 'Choose an ENV from the list', name: 'environment'),
        string(description: 'Provide AMI id', name: 'AMI_ID', trim: true),
        booleanParam(defaultValue: true, description: 'Do you want to apply?', name: 'command')        
        ])
    ])

if(params.environment == 'dev'){
    region="us-east-1"
}
else if(params.environment == 'qa'){
    region="us-east-2"
}
else{
    region="us-west-2"
}

tfvars="""
    s3_bucket = \"mybucket-alisa\"
    s3_folder_project = \"terraform\"
    s3_folder_region = \"us-east-1\"
    s3_folder_type = \"terraform-ec2-by-ami-name\"
    s3_tfstate_file = \"infrastructure.tfstate\"

    environment = \"${params.environment}\"
    region      = \"${region}\"
    public_key  = \"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDViwuHMvNuC0Hv3JkbmVk471pTwY06Pm3JBZdIN2NHYmgOOGx9PwkK5+u5eIz1WuhxqT7SGajZoH9XAsUZKx/NqEGnae6xEHPaI51zgoya2fhySZmZfEAQ4sUqoxPdT2ir0EvVhhY7N/kHrAtKhB02KnEIGwaCkbrhD4Qsi20cKzPqNtJ8o6fzCUBClwq5P+SiOPTz5uCsY6uzO0lrh7Qzuylc6KLsYcxtSuQPAFGbaTjXs+BA8SJHw2d2+fBiICQ4nXOVaw3laHjMvHhTFcMLwzIGDFjnRuXckfMI9xa3IuEIP934bZlmHd5rBYX2Q36lFHDI0iHFeETao/noHh9LzGcaGaK/bZe/hUl6MSWCRDLG4Q3aHNwyHuLOy/wpHCj8cYso/NLqqn2lF9+vF/1q3oyJ+ALCVQPRW6Ix7FjNATXDXoNHVz25DzyMcrPlwTJnIn+XIeJ043xSSf27fupdOm1a6C40gmHWkvR11Zvd1/52J6xBpa/HsWGnmak2VVU= alisaazimova@Alisas-MacBook-Pro.local\"
    ami      = \"${AMI_ID}\"

"""

node("worker1"){
    stage("Pull"){
        cleanWs()
        git 'https://github.com/alisaazi2/terraform-ec2-by-ami-name.git'
    }

    withEnv(["AWS_REGION=${region}"]) {
        withCredentials([usernamePassword(credentialsId: 'aws-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
            stage("Init"){
                writeFile file: "${params.environment}.tfvars", text: "$tfvars"

                sh """
                    #!/bin/bash
                    source ./setenv.sh ${params.environment}.tfvars 

                    cat ${params.environment}.tfvars

                    terraform init
                """
            }

            if(params.command == true){
                stage("Plan"){
                    sh """
                        terraform plan -var-file ${params.environment}.tfvars
                    """
                }

                stage("Apply"){
                    sh """
                        terraform apply -auto-approve -var-file ${params.environment}.tfvars
                    """
                }
            }
            else{
                stage("Destroy"){
                    sh """
                        terraform destroy -auto-approve -var-file ${params.environment}.tfvars
                    """
                }
            }            
        }
    }
}