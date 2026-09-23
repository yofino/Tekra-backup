import { motion } from 'framer-motion'
import { useTheme } from '../context/ThemeContext'

const variants = {
  initial: {
    opacity: 0,
    scale: 0.88,
    z: -400,
  },
  enter: {
    opacity: 1,
    scale: 1,
    z: 0,
    transition: {
      duration: 0.75,
      ease: [0.22, 1, 0.36, 1],
    },
  },
  exit: {
    opacity: 0,
    scale: 1.12,
    z: 300,
    transition: {
      duration: 0.5,
      ease: [0.55, 0, 1, 0.45],
    },
  },
}

export default function PageTransition({ children }) {
  const { dark } = useTheme()

  return (
    <div style={{
      perspective: '1400px',
      perspectiveOrigin: '50% 40%',
      background: dark ? '#0D1117' : '#EBF0FA',
      minHeight: '100vh',
    }}>
      <motion.div
        variants={variants}
        initial="initial"
        animate="enter"
        exit="exit"
        style={{ transformStyle: 'preserve-3d', willChange: 'transform, opacity' }}
      >
        {children}
      </motion.div>
    </div>
  )
}
