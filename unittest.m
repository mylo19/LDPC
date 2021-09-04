%% Test 1 - Small Matrix

H = [1 1 1 0; 0 1 0 1];
%parities_rows = [1 2 3 2 4];
%position_rows = [1 4];
%parities_columns = [1 1 2 1 2];
%position_columns = [1 2 4 5];
parities_rows = [2 3 1 2 4 1 5 2 6];
position_rows = [1 3 6 8];
parities_columns = [2 3 1 2 4 1 2 3 4];
position_columns = [1 3 6 7 8 9];

% G = [1 0 1 0; 0 1 1 1];
w = [1 0];
G = [1 0 0 1 1 0; 0 1 1 1 0 1];
codeword = w*G;
bpsk = ones(size(codeword));
for i = 1:length(codeword)
    if codeword(i) == 0
        bpsk(i) = -1;
    end
end
received_word = bpsk + normrnd(0,0.2,1,length(bpsk));
initial_word = decoder(received_word, parities_rows, parities_columns, position_rows, position_columns, 0.2);
test = initial_word == codeword';
disp(sum(test))

%% Test 2 - 5120x1024 Matrix

initial_word = rand(1,4096) > 0.5;
GeneratorMatrix

encoded_word = initial_word*Generator_Matrix;
encoded_word = mod(encoded_word,2);
 
paritiesForDecoder

bpsk = ones(size(encoded_word));
for i = 1:length(encoded_word)
    if encoded_word(i) == 0
        bpsk(i) = -1;
    end
end

parities_rows = Rows_Parity_bits;
position_rows = position_Rows;
position_columns = position_Columns;
parities_columns = Columns_Parity_bits;
received_word = bpsk + normrnd(0,0.2,1,length(bpsk));
initial_message = decoder(received_word, parities_rows, parities_columns, position_rows, position_columns, 0.2);
test = initial_word == initial_message(1:4096)';
disp(sum(test))

