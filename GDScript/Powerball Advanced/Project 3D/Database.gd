extends Spatial

# Level Done Database.
var LevelDoneNotif
var stoptimer: bool = false
 

# Level Hub World Database.
var LHWDB: int = 0

# Juice.
var just_opened: bool = false
var pausing: bool = false
var allowed_to_pause: bool = false

# Loading All Nessesary Data.
func _ready():
	_load_level_data()

func _process(delta):
	if Database.pausing:
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
	else:
		get_tree().paused = false
# Levels Database (WARNING: THE LIST IS GOING TO BE LONG!)
var filedirl = "user://leveldat.dat"

var levels = {
	"Level 1": {
	"isCompleted": false,
	},

	"Level 2": {
	"isCompleted": false,
	},

	"Level 3": {
	"isCompleted": false,
	},
	
	"Level 4": {
	"isCompleted": false,
	},
	
	"Level 5": {
	"isCompleted": false,
	},
	
	"Level 6": {
	"isCompleted": false,
	},
	
	"Level 7": {
	"isCompleted": false,
	},
	
	"Level 8": {
	"isCompleted": false,
	},
	
	"Level 9": {
	"isCompleted": false,
	},
	
	"Level 10": {
	"isCompleted": false,
	},
	
	"Level 11": {
	"isCompleted": false,
	},
	
	"Level 12": {
	"isCompleted": false,
	},
	
	"Level 13": {
	"isCompleted": false,
	},
	
	"Level 14": {
	"isCompleted": false,
	},
	
	"Level 15": {
	"isCompleted": false,
	},
	
	"Level 16": {
	"isCompleted": false,
	},
	
	"Level 17": {
	"isCompleted": false,
	},
	
	"Level 18": {
	"isCompleted": false,
	},
	
	"Level 19": {
	"isCompleted": false,
	},
	
	"Level 20": {
	"isCompleted": false,
	},
	
	"Level 21": {
	"isCompleted": false,
	},
	
	"Level 22": {
	"isCompleted": false,
	},
	
	"Level 23": {
	"isCompleted": false,
	},
	
	"Level 24": {
	"isCompleted": false,
	},
	
	"Level 25": {
	"isCompleted": false,
	},
	
	"Level 26": {
	"isCompleted": false,
	},
	
	"Level 27": {
	"isCompleted": false,
	},
	
	"Level 28": {
	"isCompleted": false,
	},
	
	"Level 29": {
	"isCompleted": false,
	},
	
	"Level 30": {
	"isCompleted": false,
	},
	
	"Level 31": {
	"isCompleted": false,
	},
	
	"Next Level Hub 1": {
	"isCompleted": false, 
	},
	
	"Next Level Hub 2": {
	"isCompleted": false,
	},
	
	"Next Level Hub 3": {
	"isCompleted": false
	},
	
	"Next Level Hub 4": {
	"isCompleted": false
	},
	
	"Next Level Hub 5": {
	"isCompleted": false
	},
	
	"Next Level Hub 6": {
	"isCompleted": false
	},
	
	"Next Level Hub 7": {
	"isCompleted": false
	}
}

func _save_level_data():

	var levelfile = File.new()
	
	levelfile.open(filedirl, File.WRITE)
	levelfile.store_var(levels)
	levelfile.close()

func _load_level_data():
	var levelfile = File.new()
	
	if levelfile.file_exists(filedirl):
		var status = levelfile.open(filedirl, File.READ)
		levels = levelfile.get_var()
		
func _erase_level_data():
	levels["Level 1"].isCompleted = false
	levels["Level 2"].isCompleted = false
	levels["Level 3"].isCompleted = false
	levels["Level 4"].isCompleted = false
	levels["Level 5"].isCompleted = false
	levels["Level 6"].isCompleted = false
	levels["Level 7"].isCompleted = false
	levels["Level 8"].isCompleted = false
	levels["Level 9"].isCompleted = false
	levels["Level 10"].isCompleted = false
	levels["Level 11"].isCompleted = false
	levels["Level 12"].isCompleted = false
	levels["Level 13"].isCompleted = false
	levels["Level 14"].isCompleted = false
	levels["Level 15"].isCompleted = false
	levels["Level 16"].isCompleted = false
	levels["Level 17"].isCompleted = false
	levels["Level 18"].isCompleted = false
	levels["Level 19"].isCompleted = false
	levels["Level 20"].isCompleted = false
	levels["Level 21"].isCompleted = false
	levels["Level 22"].isCompleted = false
	levels["Level 23"].isCompleted = false
	levels["Level 24"].isCompleted = false
	levels["Level 25"].isCompleted = false
	levels["Level 26"].isCompleted = false
	levels["Level 27"].isCompleted = false
	levels["Level 28"].isCompleted = false
	levels["Level 29"].isCompleted = false
	levels["Level 30"].isCompleted = false
	levels["Level 31"].isCompleted = false
	levels["Next Level Hub 1"].isCompleted = false
	levels["Next Level Hub 2"].isCompleted = false
	levels["Next Level Hub 3"].isCompleted = false
	levels["Next Level Hub 4"].isCompleted = false
	levels["Next Level Hub 5"].isCompleted = false
	levels["Next Level Hub 6"].isCompleted = false
	levels["Next Level Hub 7"].isCompleted = false
	LevelDoneNotif = null
	_save_level_data()

