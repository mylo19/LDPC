function [encoded_message] = encoder(message, parities, position, rows, columns, block)

encoded_message = zeros(1024,1);
for row = 1:rows
    for column = 1:columns
        index = (row-1)*columns + column;
        thisParity = position(index);
        if thisParity~=position(end)
            nextParity = position(index+1);
            parityLength = nextParity - thisParity;
        else
            parityLength = length(parities(thisParity:end));
        end
        for i = 0:parityLength-1
            parity = parities(thisParity + i) - (column-1)*block;
            for j=0:block-1
                temp = parity+j;
                if (temp > block)
                    temp = temp - block;
                end
                encoded_message((column-1)*block + temp) = encoded_message((column-1)*block + temp) + message((row-1)*block + j +1);
            end
        end
    end
end         
encoded_message = mod(encoded_message,2);
end
