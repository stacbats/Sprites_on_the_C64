//
// SPRITE2_CIRCLE.ASM
// Circular motion for sprite 2 (green sprite)
//

// Circular movement for sprite 2 using sine and cosine
circular_movement:
    // Calculate X position: X = center_x + (radius * cos(angle))
    ldx circle_angle         // Use angle as table index
    lda cosine_table,x       // Get cosine value from table
    clc
    adc #circle_center_x     // Add center X position
    sta SPRITE_X_3           // Store new X position
    
    // Calculate Y position: Y = center_y + (radius * sin(angle))
    ldx circle_angle         // Use angle as table index  
    lda circle_sine_table,x  // Get sine value from circle table
    clc
    adc #circle_center_y     // Add center Y position
    sta SPRITE_Y_3           // Store new Y position
    
    // Increment angle for next frame (3x speed)
    lda circle_angle
    clc
    adc #3                   // Add 3 each frame for 3x speed
    sta circle_angle         // This will automatically wrap at 256
    
    rts