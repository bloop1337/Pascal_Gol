program Game_Of_Life;

uses
	SysUtils;

const 
	Neighbors : Array[0..7]   of Integer = (
		-11,  -10,  -9,
		-1, (*self*) 1,
		 9,   10,   11
	);
	Update_Time : Cardinal = 1000;
var
	Current, Next: Array[0..100] of Boolean;

function Get_Neighbors(index: Integer): Integer; var
	i, res, check: Integer;
begin
	res := 0;
	for i := 0 to 7 do begin
		check := index + Neighbors[i];
		if (check >= 0) and (check < 100) and (Current[check]) then
			res := res + 1;
	end;

	Get_Neighbors := res;
end;

procedure Update_State; var
	i: Integer;
begin
	for i := 0 to 99 do begin
		if (Current[i]) and (Get_Neighbors(i) < 2) then begin
			Next[i] := false;
			continue;
		end;	
		if (Current[i]) and ((Get_Neighbors(i) = 3) or (Get_Neighbors(i) = 2)) then
			continue;

		if (Current[i]) and (Get_Neighbors(i) > 3) then begin
			Next[i] := false;
			continue;
		end;

		if (not(Current[i])) and (Get_Neighbors(i) = 3) then begin
			Next[i] := true;
			continue;
		end;
	end;
	Current := Next;
end;

procedure Init_World;
begin
	Current[1]  := true;
	Current[12] := true;
	Current[20] := true;
	Current[21] := true;
	Current[22] := true;
	Next        := Current;
end;

procedure Draw_World;
var 
	x, y: Integer;
begin
	Write(#27'[2J'#27'[H'); (* clear screen and restore cursor position*)
	for y := 0 to 9 do begin
		for x := 0 to 9 do begin
			if Current[y*10+x] then 
				Write('#')
			else 
				Write(' ');
		end;
		WriteLn('');
	end;
end;

begin
	Init_World;

	repeat
		Draw_World;
		Update_State;
		Sleep(Update_Time);
	until false;
end.
