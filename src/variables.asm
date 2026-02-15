// 
// VARIABLES.ASM
// All labels and variable definitions for sprite demo
//

// Hardware register labels - VIC-II chip sprite registers
.label SPRITE_X = $d000
.label SPRITE_Y = $d001
.label SPRITE_X_2 = $d002                 // Sprite 1 X position
.label SPRITE_Y_2 = $d003                 // Sprite 1 Y position
.label SPRITE_X_3 = $d004                 // Sprite 2 X position
.label SPRITE_Y_3 = $d005                 // Sprite 2 Y position
.label SPRITE_X_4 = $d006                 // Sprite 3 X position
.label SPRITE_Y_4 = $d007                 // Sprite 3 Y position
.label SPRITE_X_5 = $d008                 // Sprite 4 X position  
.label SPRITE_Y_5 = $d009                 // Sprite 4 Y position
.label SPRITE_X_MSB = $d010               // Sprite X MSB register (for X > 255)
.label SPRITE_ENABLE = $d015
.label SPRITE_COLOUR = $d027
.label SPRITE_COLOUR_2 = $d028            // Sprite 1 color
.label SPRITE_COLOUR_3 = $d029            // Sprite 2 color
.label SPRITE_COLOUR_4 = $d02a            // Sprite 3 color
.label SPRITE_COLOUR_5 = $d02b            // Sprite 4 color
.label SPRITE_POINTER = $C3F8             // VIC BANK 3: $C000 + $3F8
.label SPRITE_POINTER_2 = $C3F9           // Sprite 1 pointer
.label SPRITE_POINTER_3 = $C3FA           // Sprite 2 pointer
.label SPRITE_POINTER_4 = $C3FB           // Sprite 3 pointer
.label SPRITE_POINTER_5 = $C3FC           // Sprite 4 pointer
.label SPRITE_MULTICOLOR = $d01c          // Multicolor enable register
.label SPRITE_MULTICOLOR_1 = $d025        // Shared multicolor 1
.label SPRITE_MULTICOLOR_2 = $d026        // Shared multicolor 2
.label SPRITE_X_EXPAND = $d01d            // Sprite X expand register
.label SPRITE_Y_EXPAND = $d017            // Sprite Y expand register
.label RASTER_LINE = $d012                // Current raster line register

// Color constants
.label BLACK = 0
.label WHITE = 1
.label RED = 2
.label CYAN = 3
.label PURPLE = 4
.label GREEN = 5
.label BLUE = 6
.label YELLOW = 7
.label ORANGE = 8
.label BROWN = 9
.label LIGHT_RED = 10
.label DARK_GREY = 11
.label GREY = 12
.label LIGHT_GREEN = 13
.label LIGHT_BLUE = 14
.label LIGHT_GREY = 15

// Joystick labels (for future use)
.label JOYSTICK_2 = $DC00
.label JOYSTICK_2_IDLE = %01111111
.label UP = %00000001
.label DOWN = %00000010
.label LEFT = %00000100
.label RIGHT = %00001000
.label FIRE = %00010000

// Variables for sprite 0 - autonomous bouncing movement (reduced range)
.label SPRITE_MIN_Y = 50                  // Top boundary (a bit lower from top of screen)
.label SPRITE_MAX_Y = 180                 // Bottom boundary (4 pixels higher than 184)
.label movement_direction = $02           // Memory location for direction (0=down, 1=up)

// Variables for sprite 1 - sine wave movement (full screen width, within borders)
.label sine_index = $03                   // Current index in sine table (0-255)
.label wave_base_x = 24                   // Starting X position (just inside left border)
.label wave_base_y = 171                  // Base Y position (4 pixels up for higher starting position)
.label wave_amplitude = 18                // Wave height (10% less than 20 pixels up/down)
.label wave_length = 255                  // Total horizontal distance (full screen)
.label wave_direction = $05               // Direction: 0=right, 1=left

// Variables for sprite 2 - circular motion
.label circle_angle = $04                 // Current angle (0-255)
.label circle_center_x = 157              // Center X of circle (3 pixels left from 160)
.label circle_center_y = 111              // Center Y of circle (4 pixels higher from 115)
.label circle_radius = 60                 // Radius of circle in pixels

// Animation variables
.label sprite_anim_speed = 15             // Animation speed (higher = slower)
.label sprite_0_anim_counter = $06        // Animation counter for sprite 0
.label sprite_1_anim_counter = $07        // Animation counter for sprite 1
.label sprite_3_anim_counter = $08        // Animation counter for sprite 3
.label sprite_4_anim_counter = $0b        // Animation counter for sprite 4

// Sprite 3 variables (bottom right, expanded, animated, quick vertical movement)
.label sprite_3_x = 270                   // Top right X position  
.label sprite_3_y = 77                    // Starting Y position (3 pixels up from 80)
.label sprite_3_min_y = 198               // Top boundary for movement (10 pixels up)
.label sprite_3_max_y = 208               // Bottom boundary for movement (bottom but sprite fully visible)
.label sprite_3_direction = $09           // Movement direction (0=down, 1=up)
.label sprite_3_move_counter = $0a        // Movement speed counter
.label sprite_3_move_speed = 3            // Movement speed (higher = slower) - much faster!

// Sprite 4 variables (side by side with sprite 0, opposite movement)
.label sprite_4_x = 80                    // X position (next to sprite 0)
.label sprite_4_y = 140                   // Starting Y position (middle area for better visibility)