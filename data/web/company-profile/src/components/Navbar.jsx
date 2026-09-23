import { useState, useEffect } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { AnimatePresence, motion } from 'framer-motion'
import { navLinks } from '../data/nav'
import { useTheme } from '../context/ThemeContext'
import LightSwitch from './LightSwitch'

function NavLink({ link, active, dark, scrolled }) {
  const [hovered, setHovered] = useState(false)
  const isActive = active
  return (
    <Link
      to={link.path}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        boxShadow: (hovered || isActive) && dark ? '0 0 12px 2px rgba(74,95,212,0.35), inset 0 0 10px rgba(74,95,212,0.08)' : 'none',
        transition: 'box-shadow 0.25s ease, background 0.25s ease, color 0.2s ease',
      }}
      className={`text-sm font-medium px-3 py-1.5 rounded-lg ${
        isActive
          ? dark ? 'text-[#7B8FE8] bg-[#2C388E]/20 border border-[#2C388E]/40' : scrolled ? 'text-[#2C388E] bg-[#2C388E]/8 border border-[#2C388E]/20' : 'text-white bg-white/10 border border-white/20'
          : hovered
            ? dark ? 'text-white bg-[#2C388E]/15 border border-[#2C388E]/30' : scrolled ? 'text-[#2C388E] bg-[#2C388E]/6 border border-[#2C388E]/15' : 'text-white bg-white/10 border border-white/20'
            : dark ? 'text-white/75 border border-transparent' : scrolled ? 'text-gray-700 border border-transparent' : 'text-white/85 border border-transparent'
      }`}
    >
      {link.label}
    </Link>
  )
}

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const location = useLocation()
  const { dark, toggle } = useTheme()

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 50)
    window.addEventListener('scroll', onScroll)
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  useEffect(() => setMenuOpen(false), [location])

  const isScrolledLight = scrolled && !dark

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        scrolled
          ? dark
            ? 'bg-[#0D1117]/90 backdrop-blur-md border-b border-white/10'
            : 'bg-white/95 backdrop-blur-md border-b border-gray-200 shadow-sm'
          : 'bg-transparent'
      }`}
      style={{ height: '60px' }}
    >
      <div className="h-full flex items-center justify-between px-4 sm:px-6 max-w-7xl mx-auto">

        {/* Logo */}
        <Link to="/" className="shrink-0">
          <img src="/images/logoTekraFix.png" alt="Tekra" className="h-25 w-25 w-auto object-contain" />
        </Link>

        {/* Desktop Nav */}
        <nav className="hidden lg:flex items-center gap-1">
          {navLinks.map((link) => (
            <NavLink key={link.path} link={link} active={location.pathname === link.path} dark={dark} scrolled={scrolled} />
          ))}
        </nav>

        {/* Desktop CTA */}
        <div className="hidden lg:flex items-center gap-3">
          <LightSwitch />
          <Link
            to="/contact"
            className="px-5 py-2.5 rounded-xl text-white text-sm font-semibold transition-all duration-200"
            style={{ background: dark ? '#FF6700' : '#FF6700' }}
            onMouseEnter={e => e.currentTarget.style.background = '#e55c00'}
            onMouseLeave={e => e.currentTarget.style.background = '#FF6700'}
          >
            Hubungi Kami
          </Link>
        </div>

        {/* Mobile controls */}
        <div className="lg:hidden flex items-center gap-2 shrink-0">
          <LightSwitch />
          <button
            onClick={() => setMenuOpen(!menuOpen)}
            aria-label="Toggle menu"
            className="w-8 h-8 flex flex-col items-center justify-center gap-[5px]"
          >
            <span className={`w-5 h-0.5 transition-all duration-300 ${dark ? 'bg-white/70' : isScrolledLight ? 'bg-gray-800' : 'bg-white'} ${menuOpen ? 'rotate-45 translate-y-[7px]' : ''}`} />
            <span className={`w-5 h-0.5 transition-all duration-300 ${dark ? 'bg-white/70' : isScrolledLight ? 'bg-gray-800' : 'bg-white'} ${menuOpen ? 'opacity-0' : ''}`} />
            <span className={`w-5 h-0.5 transition-all duration-300 ${dark ? 'bg-white/70' : isScrolledLight ? 'bg-gray-800' : 'bg-white'} ${menuOpen ? '-rotate-45 -translate-y-[7px]' : ''}`} />
          </button>
        </div>
      </div>

      {/* Mobile Drawer */}
      <AnimatePresence>
        {menuOpen && (
          <motion.div
            key="mobile-drawer"
            initial={{ opacity: 0, y: -12 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -12 }}
            transition={{ duration: 0.25, ease: 'easeOut' }}
            className={`lg:hidden absolute top-full left-0 right-0 border-b overflow-hidden ${
              dark ? 'bg-[#0D1117]/95 backdrop-blur-md border-white/10' : 'bg-white/95 backdrop-blur-md border-gray-200'
            }`}
          >
            <nav className="flex flex-col px-4 py-3">
              {navLinks.map((link, i) => (
                <motion.div
                  key={link.path}
                  initial={{ opacity: 0, x: -16 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: i * 0.06, duration: 0.22, ease: 'easeOut' }}
                >
                  <Link
                    to={link.path}
                    className={`block py-2.5 px-3 my-0.5 text-sm font-medium rounded-lg transition-all duration-200 ${
                      location.pathname === link.path
                        ? dark ? 'text-[#7B8FE8] bg-[#2C388E]/15' : 'text-[#2C388E] bg-[#2C388E]/8'
                        : dark ? 'text-white/80 hover:text-white hover:bg-[#2C388E]/10' : 'text-gray-700 hover:text-[#2C388E] hover:bg-[#2C388E]/5'
                    }`}
                  >
                    {link.label}
                  </Link>
                </motion.div>
              ))}
              <motion.div
                initial={{ opacity: 0, y: 8 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: navLinks.length * 0.06, duration: 0.22, ease: 'easeOut' }}
              >
                <Link
                  to="/contact"
                  className="block mt-3 mb-1 py-3 rounded-xl text-white text-sm font-semibold text-center"
                  style={{ background: '#FF6700' }}
                >
                  Hubungi Kami
                </Link>
              </motion.div>
            </nav>
          </motion.div>
        )}
      </AnimatePresence>
          </header>
  )
}
