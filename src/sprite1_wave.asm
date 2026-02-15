//
// SPRITE1_WAVE.ASM
// Bidirectional sine wave movement for sprite 1 (blue sprite) - smooth continuous movement
//

// Sine wave movement for sprite 1 - smooth bidirectional movement
sine_wave_movement:
    // Check current direction
    lda wave_direction
    beq moving_right
    
    // Moving left (direction = 1) - decrement sine_index
    moving_left:
        // Calculate X position - simple direct mapping
        lda sine_index
        clc
        adc #wave_base_x         // Add base X position (24)
        sta SPRITE_X_2           // Store new X position
        
        // Calculate Y using sine lookup
        ldx sine_index           // Use sine_index for Y calculation
        lda sine_table,x         // Get sine value from table
        clc
        adc #wave_base_y         // Add base Y position
        sta SPRITE_Y_2           // Store new Y position
        
        // Check if we've reached the left boundary (sine_index = 0)
        lda sine_index
        beq switch_to_right      // If sine_index is 0, switch to moving right
        
        // Decrement sine_index (moving backwards through the wave)
        dec sine_index           // Decrease sine_index
        jmp wave_movement_done
    
    switch_to_right:
        lda #0                   // Change direction to right
        sta wave_direction
        jmp wave_movement_done
    
    // Moving right (direction = 0) - increment sine_index
    moving_right:
        // Calculate X position - simple direct mapping
        lda sine_index
        clc
        adc #wave_base_x         // Add base X position (24)
        sta SPRITE_X_2           // Store new X position
        
        // Calculate Y using sine lookup
        ldx sine_index           // Use sine_index as table index
        lda sine_table,x         // Get sine value from table
        clc
        adc #wave_base_y         // Add base Y position
        sta SPRITE_Y_2           // Store new Y position
        
        // Check if we've reached the right boundary (sine_index = 230)
        lda sine_index
        cmp #230                 // Check if at end (230)
        beq switch_to_left       // If sine_index is 230, switch to moving left
        
        // Increment sine_index (moving forward through the wave)
        inc sine_index           // Increase sine_index
        jmp wave_movement_done
    
    switch_to_left:
        lda #1                   // Change direction to left
        sta wave_direction
    
    wave_movement_done:
        rts