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

inp = gets.chomp.gsub(" ", "")
# inp = inp[0,inp.length()-1]
if not check(inp)
    puts "Input is not valid"
    exit
end
free_var = fv(inp).uniq
puts free_var.to_s