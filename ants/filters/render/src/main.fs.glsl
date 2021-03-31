uniform bool SHOW_MASK;

uniform vec2 FEEDBACK_OFFSET;
uniform float FEEDBACK_DECAY;

uniform vec3 PALETTE_A;
uniform vec3 PALETTE_B;
uniform vec3 PALETTE_C;
uniform vec3 PALETTE_D;

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    float pixel_pheromons = texture(iChannel0, uv).r;
    float interest_mask = texture(iChannel1, uv).g;
    vec3 feedback_color = texture(iChannel2, uv + (pixel_pheromons + 1.0) * FEEDBACK_OFFSET / iResolution.xy).rgb;
    feedback_color -= FEEDBACK_DECAY;


    vec2 stream_direction = vec2(
    	texture(iChannel0, uv + vec2(1.0, 0.0) / iResolution.xy).r - texture(iChannel0, uv - vec2(1.0, 0.0) / iResolution.xy).r,
    	texture(iChannel0, uv + vec2(0.0, 1.0) / iResolution.xy).r - texture(iChannel0, uv - vec2(0.0, 1.0) / iResolution.xy).r
	);

    float direction_as_hue = atan(stream_direction.y, stream_direction.x) / (2.0 * PI);
    vec3 col = palette(pixel_pheromons, PALETTE_A, PALETTE_B, PALETTE_C, PALETTE_D);

    if (SHOW_MASK) {
        col = mix(col, 1.0 - col, interest_mask);
    } else {
        col = mix(col, feedback_color, 1.0 - interest_mask);
    }

    col = clamp(col, vec3(0.0), vec3(1.0));



    // Output to screen
    fragColor = vec4(col,1.0);
}
