# 4. Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (например: А - 1).
# Letter 	A 	B 	C 	D 	E 	F 	G 	H  I	K 	L 	M 	N 	O 	P 	Q 	R 	S 	T 	V 	X 	Y 	Z

alphabet=('a'...'z').to_a
vowels =["a", "e","i","o","u","y"]
 alphabet.each_with_index do |value, index|
     vowels.each do |vowl|
       if value == vowl
         puts hash={value=>(index+1)}
     end
   end
end
