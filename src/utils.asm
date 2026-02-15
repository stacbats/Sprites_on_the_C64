//
// UTILS.ASM  
// Utility functions and lookup tables
//

// Wait for raster line synchronization
// This waits for the raster to reach line 250 (bottom of screen)
// which provides smooth 50Hz updates (PAL) or 60Hz (NTSC)
wait_for_raster:
    // Wait for raster line 250 (or adjust for desired timing)
    wait_raster_start:
        lda RASTER_LINE
        cmp #250
        bne wait_raster_start
    
    // Optional: Wait for raster to move past this line
    // to ensure we don't immediately loop again
    wait_raster_end:
        lda RASTER_LINE
        cmp #250
        beq wait_raster_end
    
    rts

// Sine lookup table (256 values, range -20 to +20 for wave amplitude)
sine_table:
.for (var i = 0; i < 256; i++) {
    .byte round(wave_amplitude * sin(toRadians(i * 360 / 256)))
}

// Cosine lookup table (256 values, range -60 to +60 for circle radius)
cosine_table:
.for (var i = 0; i < 256; i++) {
    .byte round(circle_radius * cos(toRadians(i * 360 / 256)))
}

// Enhanced sine table for circular motion (256 values, range -60 to +60 for circle radius)
// We need to redefine the sine table used by circular motion to have the right amplitude
circle_sine_table:
.for (var i = 0; i < 256; i++) {
    .byte round(circle_radius * sin(toRadians(i * 360 / 256)))
}