$all_vars = Hash.new  # To store which variables are present in the lambda term
$mapping = Hash.new
for ch in ('a'..'z') do
    $all_vars[ch] = 0
    $mapping[ch] = ch
end
$all_vars.rehash
$mapping.rehash


def check(s)
    if s == "" or (s.length() == 1 and s[0] >= 'a' and s[0] <= 'z')
        return true
    end
    counter = 0
    str = ""
    ans = false
    if s[0] >= 'a' and s[0] <= 'z'
        ans = ans || check(s[1,s.length()-1])
    end
    for i in 0...s.length()
        if s[i] == '('
            counter += 1
        elsif s[i] == ')'
            counter -= 1
        end
        str = str + s[i].to_s
        if i >= 5 and counter == 0 and str[0] == '(' and str[i] == ')' and str[1] == '\\' and str[2] >= 'a' and str[2] <= 'z' and str[3] == '.' and i+1 < s.length()
            ans = ans || (check(str[4,i-4]) && check(s[i+1,s.length()-i])) 
        end
        
        if i >= 5 and counter == 0 and str[0] == '(' and str[i] == ')' and str[1] == '\\' and str[2] >= 'a' and str[2] <= 'z' and str[3] == '.' and i+1 == s.length()
            ans = ans || check(str[4,i-4])
        end
        if ans == true
            break
        end
    end
    return ans
end

def find_free
    for c in ('a'..'z')
        if $all_vars[c] == 0
            $all_vars[c] = 1
            return c
        end
    end
    puts "All alphabet expired :("
    exit
    return 'a'  #A case when all the alphabet are used up
end

def fv(s)
    ans = []
    if s.length() <= 1
        ans = [s]
        return ans
    end
    counter = 0
    str = ""
    if s[0] >= 'a' and s[0] <= 'z'
        ans = [s[0]] + fv(s[1,s.length()-1])
        return ans
    end
    for i in 0...s.length()
        if s[i] == '('
            counter += 1
        elsif s[i] == ')'
            counter -= 1
        end
        str = str + s[i].to_s
        if i >= 5 and counter == 0 and str[0] == '(' and str[i] == ')' and str[1] == '\\' and str[2] >= 'a' and str[2] <= 'z' and str[3] == '.' and i+1 <= s.length()
            ans = fv(str[4,i-4])
            ans.delete(str[2])
            if i+1 < s.length()
                ans = ans + fv(s[i+1,s.length()-i])
            end
            break
        end
    end
    return ans
end

def alpha s, free_var
    # puts s
    # puts "enter"
    if s.length() <= 1
        return s
    end
    counter = 0
    # puts "if1"
    if s[0] >= 'a' and s[0] <= 'z'
        s = (s[0] + alpha(s[1,s.length()-1], free_var))
        return s
    end
    # puts "if2"
    for i in 0...s.length
        if s[i] == '('
            counter += 1
        elsif s[i] == ')'
            counter -= 1
        end
        if counter == 0
            if free_var.include? s[2]
                var = find_free
                bound = s[2]
                for j in 0..i
                    if s[j] == bound
                        s[j] = var
                    end
                end
            end
            # puts s[0,4]
            # puts s[4,i-4]
            s = s[0,4] + alpha(s[4,i-4], free_var) + ')' + alpha(s[i+1, s.length-i], free_var)
            return s
        end
    end
    return s
end

inp = gets.chomp.gsub(" ", "")
if not check(inp)
    puts "Input is not valid"
    exit
end
for ch in inp.chars()
    if ch >= 'a' and ch <= 'z'
        $all_vars[ch] = 1
    end
end
# puts $all_vars
free_var = fv(inp).uniq
# puts free_var

ans = alpha(inp, free_var)

puts ans