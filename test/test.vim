function! s:RangeSize() range
    echo a:lastline - a:firstline
endfunction

let MyClass = {'foo': 'Foo'}

function! MyClass.printFoo() dict
    echo self.foo
endfunction

for [a, b] in [[1, 2], [3, 4]]
    echo a b
endfor
