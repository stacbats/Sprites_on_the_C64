//
// SPRITE_ANIMATION.ASM
// Animation handler for cycling through sprite frames
//

// Animation system for sprites using multiple frames from sprites.bin
animate_sprites:
    jsr animate_sprite_0      // Animate sprite 0 (bouncing)
    jsr animate_sprite_1      // Animate sprite 1 (sine wave)
    jsr animate_sprite_3      // Animate sprite 3 (vertical)
    rts

// Animate sprite 0 (bouncing sprite) - cycles between frames 0 and 1
animate_sprite_0:
    inc sprite_0_anim_counter
    lda sprite_0_anim_counter
    cmp #sprite_anim_speed    // Change frame every X game loops
    bcc sprite_0_done
    
    // Reset counter and switch frame
    lda #0
    sta sprite_0_anim_counter
    
    // Toggle between frame 0 ($10) and frame 1 ($11)
    lda SPRITE_POINTER
    cmp #$10
    beq sprite_0_frame_1
    
    sprite_0_frame_0:
        lda #$10              // Frame 0
        sta SPRITE_POINTER
        jmp sprite_0_done
    
    sprite_0_frame_1:
        lda #$11              // Frame 1
        sta SPRITE_POINTER
    
    sprite_0_done:
        rts

// Animate sprite 1 (sine wave sprite) - cycles between frames 0 and 1
animate_sprite_1:
    inc sprite_1_anim_counter
    lda sprite_1_anim_counter
    cmp #sprite_anim_speed
    bcc sprite_1_done
    
    // Reset counter and switch frame
    lda #0
    sta sprite_1_anim_counter
    
    // Toggle between frame 0 ($10) and frame 1 ($11)
    lda SPRITE_POINTER_2
    cmp #$10
    beq sprite_1_frame_1
    
    sprite_1_frame_0:
        lda #$10              // Frame 0
        sta SPRITE_POINTER_2
        jmp sprite_1_done
    
    sprite_1_frame_1:
        lda #$11              // Frame 1
        sta SPRITE_POINTER_2
    
    sprite_1_done:
        rts

// Animate sprite 3 (vertical movement sprite) - cycles between frames 0 and 1
animate_sprite_3:
    inc sprite_3_anim_counter
    lda sprite_3_anim_counter
    cmp #sprite_anim_speed
    bcc sprite_3_done
    
    // Reset counter and switch frame
    lda #0
    sta sprite_3_anim_counter
    
    // Toggle between frame 0 ($10) and frame 1 ($11)
    lda SPRITE_POINTER_4
    cmp #$10
    beq sprite_3_frame_1
    
    sprite_3_frame_0:
        lda #$10              // Frame 0
        sta SPRITE_POINTER_4
        jmp sprite_3_done
    
    sprite_3_frame_1:
        lda #$11              // Frame 1
        sta SPRITE_POINTER_4
    
    sprite_3_done:
        rts

// Animate sprite 4 (opposite bouncing sprite) - cycles between frames 0 and 1
animate_sprite_4:
    inc sprite_4_anim_counter
    lda sprite_4_anim_counter
    cmp #sprite_anim_speed
    bcc sprite_4_done
    
    // Reset counter and switch frame
    lda #0
    sta sprite_4_anim_counter
    
    // Toggle between frame 0 ($80) and frame 1 ($81)
    lda SPRITE_POINTER_5
    cmp #$80
    beq sprite_4_frame_1
    
    sprite_4_frame_0:
        lda #$80              // Frame 0
        sta SPRITE_POINTER_5
        jmp sprite_4_done
    
    sprite_4_frame_1:
        lda #$81              // Frame 1
        sta SPRITE_POINTER_5
    
    sprite_4_done:
        rts