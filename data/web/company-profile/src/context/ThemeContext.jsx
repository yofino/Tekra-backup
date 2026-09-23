import { createContext, useContext, useEffect, useRef, useState } from 'react'

const ThemeContext = createContext()

export function ThemeProvider({ children }) {
  const [dark, setDark] = useState(() => {
    const saved = localStorage.getItem('theme')
    if (saved) return saved === 'dark'
    return window.matchMedia('(prefers-color-scheme: dark)').matches
  })
  const overlayRef = useRef(null)

  useEffect(() => {
    const root = document.documentElement
    if (dark) {
      root.classList.add('dark')
      localStorage.setItem('theme', 'dark')
    } else {
      root.classList.remove('dark')
      localStorage.setItem('theme', 'light')
    }
  }, [dark])

  const toggle = () => {
    const overlay = overlayRef.current
    if (!overlay) { setDark(d => !d); return }

    const goingDark = !dark
    // warna flash: kuning hangat saat ke light, biru gelap saat ke dark
    overlay.style.background = goingDark
      ? 'radial-gradient(ellipse at center, rgba(44,56,142,0.35) 0%, transparent 70%)'
      : 'radial-gradient(ellipse at center, rgba(255,103,0,0.25) 0%, transparent 70%)'
    overlay.style.opacity = '1'
    overlay.style.transition = 'opacity 0ms'

    setDark(d => !d)

    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        overlay.style.transition = 'opacity 700ms ease'
        overlay.style.opacity = '0'
      })
    })
  }

  return (
    <ThemeContext.Provider value={{ dark, toggle }}>
      {children}
      <div
        ref={overlayRef}
        style={{
          position: 'fixed', inset: 0, zIndex: 9999,
          opacity: 0, pointerEvents: 'none',
        }}
      />
    </ThemeContext.Provider>
  )
}

export const useTheme = () => useContext(ThemeContext)
