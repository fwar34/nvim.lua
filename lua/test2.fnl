(lambda print-cacluation [x ?y z]
  (print (- x (* (or ?y 1) z))))

(print-cacluation 5 nil 3)

(let [x (+ 89 5.2)
      f (fn [abc] (print (* 2 abc)))]
  (f x))

(local tau-approx 6.28318)
