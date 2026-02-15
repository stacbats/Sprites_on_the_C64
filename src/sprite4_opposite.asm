//
// SPRITE4_OPPOSITE.ASM
// Opposite vertical movement to sprite 0 (sprite 4 moves opposite to sprite 0)
//

// Sprite 4 movement - mirrors sprite 0 but in opposite direction
sprite4_opposite_movement:
    // Get sprite 0's current direction and do the opposite
    lda movement_direction
    beq sprite4_moving_up        // If sprite 0 is moving down (0), sprite 4 moves up
    
    // Sprite 0 is moving up, so sprite 4 moves down
    sprite4_moving_down:
        lda SPRITE_Y_5
        cmp #SPRITE_MAX_Y
        beq sprite4_done          // If at bottom, stop (sprite 0 will reverse soon)
        inc SPRITE_Y_5            // Move down
        jmp sprite4_done
    
    // Sprite 0 is moving down, so sprite 4 moves up  
    sprite4_moving_up:
        lda SPRITE_Y_5
        cmp #SPRITE_MIN_Y
        beq sprite4_done          // If at top, stop (sprite 0 will reverse soon)
        dec SPRITE_Y_5            // Move up
    
    sprite4_done:
        rts