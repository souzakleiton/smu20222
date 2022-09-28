PILHA=smu
ARQUIVO=ec2+eip.json
CHAVE=ederson.torresini

all: create

create:
	aws cloudformation create-stack \
	--stack-name ${PILHA} \
	--template-body file://${ARQUIVO} \
	--parameters ParameterKey=KeyName,ParameterValue=${CHAVE}

destroy:
	aws cloudformation delete-stack --stack-name ${PILHA}
