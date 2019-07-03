
echo "=> Starting Other Installations"

for SHELL in $ROOT_DIR/shells/extra_installations/*
do
  sh $SHELL
done