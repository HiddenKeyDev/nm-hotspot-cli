# Maintainer: HiddenKeyDev
pkgname=nm-hotspot-cli
pkgver=1.0.0
pkgrel=1
pkgdesc="Simple command-line tool to create and manage Wi-Fi hotspots using NetworkManager"
arch=('any')
url="https://github.com/HiddenKeyDev/nm-hotspot-cli"
license=('MIT')
depends=('networkmanager' 'bash')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('SKIP')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    
    # Install main script
    install -Dm755 src/nm-hotspot "${pkgdir}/usr/bin/nm-hotspot"
    
    # Install license
    install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
    
    # Install documentation
    install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
    install -Dm644 docs/CONTRIBUTING.md "${pkgdir}/usr/share/doc/${pkgname}/CONTRIBUTING.md"
    install -Dm644 docs/QUICKREF.md "${pkgdir}/usr/share/doc/${pkgname}/QUICKREF.md"
}
