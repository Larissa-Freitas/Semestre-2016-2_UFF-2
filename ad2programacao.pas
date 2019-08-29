program strMatching;
Type
	OperType = (UNDEFINED, MATCH, INSERT, DELETE);
cell = record
	cost:integer;
	parent: OperType;
end;
var str1, str2, str3, str4: String;
	dist: integer;
	m: Array [0..MAXLEN, 0..MAXLEN] of cell;
function indel (c: char):integer;
begin
	indel:= 1;
end;
function char_match (c:char; d: char): integer;
begin
	if (c <> d) then char_match:= 1
	else char_match := 0;
end;
function string_compare (s: string; t: string; i: integer; j: integer): integer;
var
	k: OperType;
	opt: Array [OperType] of integer;
	lowest_cost: integer;
begin
	if (i = 0) then
	begin
		string_compare:= j*indel(' ');
		exit
	end;
	if(j = 0) then
	begin
		string_compare := i*indel(' ');
		exit
	end;
	opt[MATCH] := string_compare(s, t, i-1, j-1) + char_match(s[i],t[j]);
	opt[INSERT] := string_compare (s, t, i, j-1) + indel(t[j]);
	opt[DELETE] := string_compare (s, t, i-1, j) + indel(s[i]);
	lowest_cost := opt[MATCH];
	for k:= INSERT to DELETE do begin
		if (opt[k] < lowest_cost) then lowest_cost := opt[k]
	end;
	string_compare := lowest_cost;
end;
begin
	str1:= 'GAATTCAGTTA';
	str2:= 'GGATCGA';
	str3:= 'thou-shalt-not';
	str4:= 'you-shoud-not';
	dist:= string_compare (str1, str2, length(str1),length(str2));
	writeln (dist, 'moves');
end.