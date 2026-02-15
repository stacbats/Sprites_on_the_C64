// 
// MAIN.ASM
// Inspired by too many people to mention
// Main game loop and initialization for sprite demo
//

BasicUpstart2(main)

// Include zero page definitions and VIC library
#import "zeropage.asm"
#import "../libs/vic.asm"

// Include all variable definitions FIRST
#import "variables.asm"

// Include utility functions and lookup tables
#import "utils.asm"

// Include sprite movement and animation modules
#import "Sprite0_bounce.asm"
#import "Sprite1_wave.asm"
#import "Sprite2_circle.asm"
#import "Sprite3_vertical.asm"
#import "Sprite4_opposite.asm"
#import "Sprite_animation.asm"

// Include map loader and assets
START:
#import "maps/maploader.asm"


main: 
    // Initialize VIC and memory setup
    lda #$00
    sta VIC.BACKGROUND_COLOR
    sta VIC.BORDER_COLOR

    lda #$7f    //Disable CIA IRQ's to prevent crash
    sta $dc0d
    sta $dd0d

    //Bank out BASIC and Kernal ROM
    lda $01
    and #%11111000
    ora #%00000101
    sta $01

    //Set VIC BANK 3
    lda $dd00
    and #%11111100
    sta $dd00

    //Set screen and character memory
    lda #%00001100
    sta VIC.MEMORY_SETUP

    // Draw the map
    jsr MAPLOADER.DrawMap
    
    // Set background color (after VIC setup, don't use KERNAL clear)
    lda #BLACK            // Set background to grey
    sta $d020            // Border color
    sta $d021            // Background color
    
    // Set up sprite 0 (bouncing sprite - top left)
    lda #54          // X position (4 pixels to the right)
    sta SPRITE_X          // Sprite 0 X position
    lda #SPRITE_MIN_Y     // Y position (start at top)
    sta SPRITE_Y          // Sprite 0 Y position
    lda #$10           // Sprite pointer Index (VIC BANK 3: $C400/64 = $10)
    sta SPRITE_POINTER          // Sprite 0 pointer
    lda #WHITE          // White color
    sta SPRITE_COLOUR

    // Set up sprite 1 (sine wave sprite - bottom left)
    lda #wave_base_x     // X position (bottom left start)
    sta SPRITE_X_2       // Sprite 1 X position
    lda #wave_base_y     // Y position (bottom area)
    sta SPRITE_Y_2       // Sprite 1 Y position
    lda #$10             // Same sprite shape (VIC BANK 3: $C400/64 = $10)
    sta SPRITE_POINTER_2 // Sprite 1 pointer
    lda #WHITE           // White color
    sta SPRITE_COLOUR_2

    // Set up sprite 2 (circular motion sprite - center)
    lda #circle_center_x // X position (center)
    sta SPRITE_X_3       // Sprite 2 X position
    lda #circle_center_y // Y position (center)
    sta SPRITE_Y_3       // Sprite 2 Y position
    lda #$10             // Same sprite shape (VIC BANK 3: $C400/64 = $10)
    sta SPRITE_POINTER_3 // Sprite 2 pointer
    lda #WHITE           // White color
    sta SPRITE_COLOUR_3

    // Set up sprite 3 (vertical movement sprite - bottom right)
    lda #<sprite_3_x     // Low byte of X position (270)
    sta SPRITE_X_4       // Sprite 3 X position
    lda #>sprite_3_x     // High byte for X coordinate > 255
    beq no_x_msb_3       // If high byte is 0, skip MSB setting
    lda SPRITE_X_MSB     // Load current MSB register
    ora #%00001000       // Set bit 3 for sprite 3
    sta SPRITE_X_MSB     // Store back
    no_x_msb_3:
    lda #sprite_3_y      // Y position (bottom right)
    sta SPRITE_Y_4       // Sprite 3 Y position
    lda #$10             // Same sprite shape (VIC BANK 3: $C400/64 = $10)
    sta SPRITE_POINTER_4 // Sprite 3 pointer
    lda #WHITE           // White color
    sta SPRITE_COLOUR_4

    // Enable four sprites (bits 0, 1, 2, and 3)
    lda #%00001111       // Enable sprites 0, 1, 2, and 3
    sta SPRITE_ENABLE          // Sprite enable register

    // Disable multicolor for all sprites (hires mode)
    lda #%00000000   // Disable multicolor for all sprites (hires mode)
    sta SPRITE_MULTICOLOR

    // Disable sprite expansion (no expanded sprites)
    lda #%00000000       // Disable X expansion for all sprites
    sta SPRITE_X_EXPAND
    lda #%00000000       // Disable Y expansion for all sprites
    sta SPRITE_Y_EXPAND

    // Initialize movement variables
    lda #0
    sta movement_direction    // Sprite 0 moving down initially
    lda #0
    sta sine_index           // Sprite 1 starts at beginning of sine wave
    lda #0
    sta wave_direction       // Sprite 1 starts moving right
    lda #0
    sta circle_angle         // Sprite 2 starts at angle 0
    
    // Initialize animation counters
    lda #0
    sta sprite_0_anim_counter
    lda #0
    sta sprite_1_anim_counter
    lda #0
    sta sprite_3_anim_counter
    
    // Initialize sprite 3 movement variables
    lda #0
    sta sprite_3_direction       // Start moving down
    lda #0
    sta sprite_3_move_counter    // Reset movement counter

GameLoop:
    jsr wait_for_raster
    jsr animate_sprites          // Animate all sprites first
    jsr autonomous_movement      // Move sprite 0 (bouncing)
    jsr sine_wave_movement       // Move sprite 1 (sine wave)
    jsr circular_movement        // Move sprite 2 (circular)
    // sprite 3 stays static at top-right position
    jmp GameLoop




// Sprite data (VIC BANK 3: place sprites at $C400 as per memory map)
*=$C400 "My Sprite"
.import binary "..\SpritePadFiles\sprites.bin"

// Include map assets
#import "maps/assets.asm"