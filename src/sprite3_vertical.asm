//
// SPRITE3_VERTICAL.ASM
// Slow vertical movement for sprite 3 (yellow expanded sprite)
//

// Slow vertical movement for sprite 3 - moves up and down 7 pixels
sprite3_vertical_movement:
    // Increment movement counter for slow movement
    inc sprite_3_move_counter
    lda sprite_3_move_counter
    cmp #sprite_3_move_speed    // Move only every X frames
    bcc sprite3_movement_done   // If counter < speed, skip movement
    
    // Reset counter and perform movement
    lda #0
    sta sprite_3_move_counter
    
    // Check current direction
    lda sprite_3_direction
    beq sprite3_moving_down
    
    // Moving up
    sprite3_moving_up:
        lda SPRITE_Y_4
        cmp #sprite_3_min_y
        beq sprite3_switch_to_down    // If at top, switch direction
        dec SPRITE_Y_4                // Move up (decrease Y)
        jmp sprite3_movement_done
    
    sprite3_switch_to_down:
        lda #0                        // Set direction to down
        sta sprite_3_direction
        jmp sprite3_movement_done
    
    // Moving down
    sprite3_moving_down:
        lda SPRITE_Y_4
        cmp #sprite_3_max_y
        beq sprite3_switch_to_up      // If at bottom, switch direction
        inc SPRITE_Y_4                // Move down (increase Y)
        jmp sprite3_movement_done
    
    sprite3_switch_to_up:
        lda #1                        // Set direction to up
        sta sprite_3_direction
    
    sprite3_movement_done:
        rts