source "$REPOROOT/utils/appimage.sh"
source "$REPOROOT/utils/tracing.sh"

install_amazonq() {
    info "Installing Amazon Q..."
    local url="https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.appimage"
    install_appimage $1 "$url" || retun 1
    info "Installed Amazon Q"
}
