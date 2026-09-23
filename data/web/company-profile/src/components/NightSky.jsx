import { useTheme } from '../context/ThemeContext'

const stars = [
  { size: 6,  top: '8%',  delay: '0s',   dur: '3.2s', glow: 'rgba(255,220,100,0.9)'  },
  { size: 4,  top: '18%', delay: '0.4s', dur: '2.8s', glow: 'rgba(255,240,160,0.8)'  },
  { size: 7,  top: '32%', delay: '0.9s', dur: '3.5s', glow: 'rgba(255,220,100,0.9)'  },
  { size: 3,  top: '45%', delay: '1.3s', dur: '2.5s', glow: 'rgba(200,220,255,0.8)'  },
  { size: 5,  top: '58%', delay: '0.6s', dur: '3.0s', glow: 'rgba(255,220,100,0.85)' },
  { size: 4,  top: '70%', delay: '1.7s', dur: '2.7s', glow: 'rgba(255,240,160,0.7)'  },
  { size: 6,  top: '82%', delay: '1.1s', dur: '3.3s', glow: 'rgba(255,220,100,0.9)'  },
]

export default function NightSky() {
  const { dark } = useTheme()

  return (
    <div
      className="fixed right-0 top-0 h-full w-32 pointer-events-none z-40"
      style={{ opacity: dark ? 1 : 0, transition: 'opacity 0.8s ease' }}
    >
      {/* ── Bulan sabit ── */}
      <div
        style={{
          position: 'absolute',
          top: dark ? '5%' : '-20%',
          right: '36px',
          transition: 'top 1.2s cubic-bezier(0.22,1,0.36,1)',
          animation: dark ? 'moon-glow 3s ease-in-out infinite' : 'none',
        }}
      >
        <svg width="90" height="90" viewBox="0 0 90 90" fill="none" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <radialGradient id="moonGrad" cx="60%" cy="35%" r="60%">
              <stop offset="0%"   stopColor="#FFF5A0" />
              <stop offset="50%"  stopColor="#FFD84D" />
              <stop offset="100%" stopColor="#C8860A" />
            </radialGradient>
            <radialGradient id="crater1" cx="50%" cy="50%" r="50%">
              <stop offset="0%"   stopColor="rgba(100,60,0,0.45)" />
              <stop offset="100%" stopColor="rgba(100,60,0,0)" />
            </radialGradient>
            <radialGradient id="crater2" cx="50%" cy="50%" r="50%">
              <stop offset="0%"   stopColor="rgba(80,40,0,0.35)" />
              <stop offset="100%" stopColor="rgba(80,40,0,0)" />
            </radialGradient>
            <radialGradient id="crater3" cx="50%" cy="50%" r="50%">
              <stop offset="0%"   stopColor="rgba(120,70,0,0.30)" />
              <stop offset="100%" stopColor="rgba(120,70,0,0)" />
            </radialGradient>
            <radialGradient id="moonShine" cx="30%" cy="25%" r="45%">
              <stop offset="0%"   stopColor="rgba(255,255,220,0.55)" />
              <stop offset="100%" stopColor="rgba(255,255,220,0)" />
            </radialGradient>
            <clipPath id="crescentClip">
              <path d="M68 45C68 59.912 55.912 72 41 72C33.544 72 26.82 68.786 22.2 63.6C24.2 64.3 26.36 64.66 28.6 64.66C43.512 64.66 55.6 52.572 55.6 37.66C55.6 29.74 52.04 22.64 46.44 17.76C47.88 17.52 49.32 17.4 50.8 17.4C63.708 17.4 68 30.088 68 45Z" />
            </clipPath>
          </defs>

          <path
            d="M68 45C68 59.912 55.912 72 41 72C33.544 72 26.82 68.786 22.2 63.6C24.2 64.3 26.36 64.66 28.6 64.66C43.512 64.66 55.6 52.572 55.6 37.66C55.6 29.74 52.04 22.64 46.44 17.76C47.88 17.52 49.32 17.4 50.8 17.4C63.708 17.4 68 30.088 68 45Z"
            fill="url(#moonGrad)"
          />
          <g clipPath="url(#crescentClip)">
            <ellipse cx="32" cy="48" rx="7"   ry="6"   fill="url(#crater1)" />
            <ellipse cx="32" cy="48" rx="5"   ry="4"   fill="none" stroke="rgba(90,50,0,0.25)"  strokeWidth="1" />
            <ellipse cx="50" cy="30" rx="4.5" ry="4"   fill="url(#crater2)" />
            <ellipse cx="50" cy="30" rx="3"   ry="2.5" fill="none" stroke="rgba(80,40,0,0.20)"  strokeWidth="0.8" />
            <ellipse cx="38" cy="60" rx="3.5" ry="3"   fill="url(#crater3)" />
            <circle cx="44" cy="42" r="1.5" fill="rgba(100,55,0,0.20)" />
            <circle cx="28" cy="36" r="1.2" fill="rgba(100,55,0,0.18)" />
            <circle cx="55" cy="50" r="1.8" fill="rgba(90,50,0,0.15)"  />
            <circle cx="42" cy="55" r="1"   fill="rgba(100,55,0,0.18)" />
            <path
              d="M68 45C68 59.912 55.912 72 41 72C33.544 72 26.82 68.786 22.2 63.6C24.2 64.3 26.36 64.66 28.6 64.66C43.512 64.66 55.6 52.572 55.6 37.66C55.6 29.74 52.04 22.64 46.44 17.76C47.88 17.52 49.32 17.4 50.8 17.4C63.708 17.4 68 30.088 68 45Z"
              fill="url(#moonShine)"
            />
          </g>
        </svg>
      </div>

      {/* ── Bintang-bintang ── */}
      {stars.map((s, i) => (
        <div
          key={i}
          style={{
            position: 'absolute',
            top: dark ? s.top : '-10%',
            right: `${20 + (i % 3) * 18}px`,
            transition: `top 1.4s cubic-bezier(0.22,1,0.36,1) ${s.delay}`,
            animation: dark ? `star-twinkle ${s.dur} ease-in-out infinite ${s.delay}` : 'none',
            filter: `drop-shadow(0 0 ${s.size + 2}px ${s.glow}) drop-shadow(0 0 ${s.size * 2}px ${s.glow})`,
          }}
        >
          <svg width={s.size * 2.5} height={s.size * 2.5} viewBox="0 0 20 20" fill="none">
            <polygon points="10,1 12.4,7.3 19,7.3 13.8,11.4 15.9,18 10,14.2 4.1,18 6.2,11.4 1,7.3 7.6,7.3" fill="#FFE066" />
          </svg>
        </div>
      ))}
    </div>
  )
}
