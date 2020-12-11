(ns testclj.core)
    (defn foo [x]
     (println x "Hello world!")
     )
(foo "feng")

(fn print-add [ a b c ]
  (print a)
  (+ b c)
  )

(fn print-sep []
  "doc print-sep"
  (print "xx"))
(doc print-sep)
