{"key" 333
 "number" 531
 "f" (fn [x] (+ x 2))}

(let [tbl {"key" 333 "number" 531 "f" (fn [x] (+ x 2))}
      key "a certain key"]
  (. tbl "key"))

(let [tbl {}
      key1 "a long string"
      key2 12]
  (tset tbl key1 "the first value")
  (tset tbl key2 "the second one")
  tbl)

(local ltrs ["a" "b" "c" "d"])
(table.remove ltrs)
(table.remove ltrs 1)
(table.insert ltrs "d")
(table.insert ltrs 1 "a")
(. ltrs 2)

(let [tbl ["abc" "def" "xyz"]]
  (+ (length tbl) 
     (length (. tbl 1))))

(each [key value (pairs {"key1" 52 "key2" 99})]
  (print key value))

(each [index value (ipairs ["abc" "def" "xyz"])]
  (print index value))

(var num 0)
(each [digits (string.gmatch "244 127 163" "%d+")]
  (set num (+ num (tonumber digits))))
num

(for [i 1 10]
  (print i))

(for [i 1 10 2]
  (print i))

(let [x (math.random 64)]
  (if (= 0 (% x 2))
    "even"
    (= 0 (% x 10))
    "multiple of ten"
    "I dunno, something else"))

{:key 33 :number 334}

(let [tbl {:x 52 :y 99}]
  (+ tbl.x tbl.y))

(let [tbl {}]
  (set tbl.x 33)
  (set tbl.y 44)
  tbl)

(let [one 1 two 2
      tbl {: one : two}]
  tbl)
