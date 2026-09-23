import { useRef } from 'react'
import { motion, useInView } from 'framer-motion'

const variants = {
  up:    { hidden: { opacity: 0, y: 30 },      visible: { opacity: 1, y: 0 } },
  down:  { hidden: { opacity: 0, y: -30 },     visible: { opacity: 1, y: 0 } },
  left:  { hidden: { opacity: 0, x: 0, y: 20 }, visible: { opacity: 1, x: 0, y: 0 } },
  right: { hidden: { opacity: 0, x: 0, y: 20 }, visible: { opacity: 1, x: 0, y: 0 } },
  scale: { hidden: { opacity: 0, scale: 0.95 }, visible: { opacity: 1, scale: 1 } },
  fade:  { hidden: { opacity: 0 },             visible: { opacity: 1 } },
}

const spring = { type: 'spring', stiffness: 60, damping: 18, mass: 0.8 }

export default function SectionReveal({ children, direction = 'up', delay = 0, className = '' }) {
  const ref = useRef(null)
  const inView = useInView(ref, { once: true, margin: '0px 0px' })

  return (
    <motion.div
      ref={ref}
      variants={variants[direction]}
      initial="hidden"
      animate={inView ? 'visible' : 'hidden'}
      transition={{ ...spring, delay }}
      className={`w-full ${className}`}
    >
      {children}
    </motion.div>
  )
}
