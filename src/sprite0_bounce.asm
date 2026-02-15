//
// SPRITE0_BOUNCE.ASM
// Autonomous bouncing movement for sprite 0 (red sprite)
//

// Autonomous movement routine - moves sprite up and down
autonomous_movement:
    lda movement_direction
    beq moving_down
    
    // Moving up
    moving_up:
        lda SPRITE_Y
        cmp #SPRITE_MIN_Y
        beq switch_to_down    // If at top, switch direction
        dec SPRITE_Y          // Move up
        jmp movement_done
    
    switch_to_down:
        lda #0                // Set direction to down
        sta movement_direction
        jmp movement_done
    
    // Moving down
    moving_down:
        lda SPRITE_Y
        cmp #SPRITE_MAX_Y
        beq switch_to_up      // If at bottom, switch direction
        inc SPRITE_Y          // Move down
        jmp movement_done
    
    switch_to_up:
        lda #1                // Set direction to up
        sta movement_direction
    
    movement_done:
        rts