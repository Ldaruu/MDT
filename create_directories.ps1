ForEach ($Dir in ("User","Uni Yr 1", "Uni Yr 2", "Uni Yr 3")){
	New-Item -ItemType Directory -Path "L:\$Dir"
	if ( $Dir -ne "User" ){
		ForEach($SubDir in ("Module 1 [rename]", "Module 2 [rename]", "Module 3 [rename]","Module 4 [rename]")){
			New-Item -ItemType Directory -Path "L:\$Dir\$SubDir"
		}
	}else{
		ForEach($UserDir in( "Desktop", "Documents", "Downloads",  "Pictures", "Music", "Videos", "3D Objects")){
			New-Item -ItemType Directory -Path "L:\User\$UserDir"
		}
	}
} 
