Execute the code using command:
ruby Qx.rb , where x is the question no.

For Q1, every valid input will yield true and other cases will print false.
Valid input is of the form:

Variable OR (\variable.Lambda-term) OR Lambda-term Lambda-term
(We have considered the combination of two valid Lambda Terms without adding explicit brackets for each of them again)
Whitespaces if present are removed from the term before any further processing.
Parenthesis are only present for abstraction terms and nowhere else.

examples of valid terms - a, abcd, (\x.xyz), (\a.(\b.ba))(\a.xya) , (\x.xx)(\x.xx)(\y.abc)(\z.abcdxyz) , (\y.(\x.x(yy)))x
examples of invalid lambda terms, according to notation considered - (a), \a.a , (\ab.abc), (\a)(\b.b) , ((\a.ab))

For the following questions, input will be given in a valid format only.
An error will be thrown if the input would not be in valid format.

For Q2, free variables inside the complete lambda term will be printed for every valid input.

For Q3, free variables that are present as bound variable in any other term, will be alpha-substituted and then the entire term will be printed.

For Q4,term will be beta-reduced till the normal form is obtained. If there are more than 100 reduction steps (ex. (\x.xx)(\x.xx) ), it is considered to be infinite and the term obtained after 100 reductions will be printed.
As Application associates to the left, our algorithm does the process of beta reduction from left to right. That is the reduction of the leftmost bounded variable term is done first then later ones.