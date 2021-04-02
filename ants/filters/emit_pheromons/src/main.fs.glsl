uniform float ANT_SIZE;
uniform int ANT_COUNT;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;
    float pixel_pheromons = 0.0;
    float pixel_ants = 0.0;
    
    float size = ANT_SIZE / iResolution.x;
    size *= size;
    vec2 distance_factor = iResolution.xy / iResolution.yy;
    for (int i = 0; i < ANT_COUNT; i++) {

        int j = i / int(iResolution.x);
        vec4 ant_info = texelFetch(iChannel0, ivec2(i % int(iResolution.x), j), 0).rgba;

        vec2 ant_pos = ant_info.xy;
        float ant_direction = ant_info.w;

        float ant_pheromon = ant_info.z;
        
        vec2 ant_distance = (uv - ant_pos) * distance_factor;
        ant_distance.x *= ant_distance.x;
        ant_distance.y *= ant_distance.y;
        float close_to_ant = smoothstep(-0.5 * size, 0.5 * size, size - (ant_distance.x + ant_distance.y));
        
        
        pixel_pheromons = clamp(close_to_ant * ant_pheromon, pixel_pheromons, 1.0); 
        
        pixel_ants = max(pixel_ants, close_to_ant); 
    }

    float pixel_on_peak = texture(iChannel1, uv).r;

    //pixel_pheromons *= 1.0 - pixel_on_peak * 0.0001;
    
    fragColor = vec4(pixel_pheromons, pixel_ants, 0.0, 1.0);
}
