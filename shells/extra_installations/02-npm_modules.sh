
echo "=> Install npm modules"

print_info "Installing vtop..."

# NOTE make sure node is installed, right now fe_setup is run before this so it's ok.

# install vtop
npm install -g vtop

print_success "Completed..."