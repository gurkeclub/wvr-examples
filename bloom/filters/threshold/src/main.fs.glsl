void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    vec3 color = vec3(0.0);
    color = texture(iChannel0, uv.xy).rgb;
    
    color *= smoothstep(1.0, sqrt(2.0), length(color));
    
    fragColor = vec4(color,1.0);
}
