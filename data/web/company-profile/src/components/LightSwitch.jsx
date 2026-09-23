import { useState } from 'react'
import { useTheme } from '../context/ThemeContext'

export default function LightSwitch() {
  const { dark, toggle } = useTheme()
  const [cordClass, setCordClass] = useState('')

  function handleHover() {
    if (cordClass === 'cord-pull') return
    setCordClass('cord-hover')
  }

  function handleLeave() {
    setCordClass('')
  }

  function handleClick() {
    setCordClass('cord-pull')
    toggle()
    setTimeout(() => setCordClass(''), 500)
  }

  const on = !dark

  return (
    <button
      onClick={handleClick}
      onMouseEnter={handleHover}
      onMouseLeave={handleLeave}
      aria-label="Toggle theme"
      title={dark ? 'Switch to Light' : 'Switch to Dark'}
      style={{
        background: 'none', border: 'none', cursor: 'pointer',
        padding: 0, display: 'flex', flexDirection: 'column',
        alignItems: 'center', width: 40, position: 'relative',
      }}
    >
      {/* Kabel dari atas */}
      <div style={{
        width: 2, height: 6,
        background: on ? '#b8860b' : '#555',
        borderRadius: 1,
        flexShrink: 0,
      }} />

      {/* Lampu kerucut */}
      <svg width="38" height="34" viewBox="0 0 38 34" fill="none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="shade-on" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#FFE066" />
            <stop offset="100%" stopColor="#FFA500" />
          </linearGradient>
          <linearGradient id="shade-off" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#2a2a3a" />
            <stop offset="100%" stopColor="#1a1a28" />
          </linearGradient>
          <radialGradient id="light-beam" cx="50%" cy="0%" r="80%">
            <stop offset="0%" stopColor={on ? 'rgba(255,220,80,0.55)' : 'rgba(0,0,0,0)'} />
            <stop offset="100%" stopColor="rgba(0,0,0,0)" />
          </radialGradient>
        </defs>

        {/* Cahaya menyebar ke bawah (cone beam) */}
        {on && (
          <path
            d="M13 22 L2 52 L36 52 L25 22 Z"
            fill="url(#light-beam)"
            opacity="0.7"
          />
        )}

        {/* Tutup atas (cap) */}
        <rect x="13" y="2" width="12" height="4" rx="2"
          fill={on ? '#b8860b' : '#333'}
          style={{ transition: 'fill 0.3s' }}
        />

        {/* Badan kerucut */}
        <path
          d="M13 6 L6 26 L32 26 L25 6 Z"
          fill={on ? 'url(#shade-on)' : 'url(#shade-off)'}
          style={{ transition: 'fill 0.3s' }}
        />

        {/* Rim bawah */}
        <rect x="5" y="24" width="28" height="3" rx="1.5"
          fill={on ? '#cc8800' : '#222233'}
          style={{ transition: 'fill 0.3s' }}
        />

        {/* Kilap sisi kiri */}
        {on && (
          <path d="M14 8 L10 20" stroke="rgba(255,255,255,0.3)" strokeWidth="2" strokeLinecap="round" />
        )}

        {/* Bohlam kecil di dalam */}
        <circle cx="19" cy="20" r="3"
          fill={on ? '#FFF5AA' : '#1a1a28'}
          style={{ transition: 'fill 0.3s', filter: on ? 'drop-shadow(0 0 4px #FFE066)' : 'none' }}
        />
      </svg>

      {/* Tali + ujung tali */}
      <div
        className={cordClass}
        style={{
          display: 'flex', flexDirection: 'column', alignItems: 'center',
          transformOrigin: 'top center',
        }}
      >
        <div style={{
          width: 2, height: 14,
          background: on ? '#b8860b' : '#555',
          borderRadius: 1,
          transition: 'background 0.3s',
        }} />
        {/* Cincin ujung tali */}
        <div style={{
          width: 8, height: 8,
          borderRadius: '50%',
          border: `2px solid ${on ? '#b8860b' : '#555'}`,
          background: 'transparent',
          transition: 'border-color 0.3s',
        }} />
      </div>
    </button>
  )
}
