void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 forest_color = texture(iChannel0, vec2(uv.x, uv.y)).rgb;

  vec3 bloom_color = 1.0 * texture(iChannel1, uv).rgb;
  vec3 threshold_color = texture(iChannel2, uv).rgb;

  vec3 color = forest_color * 1.0 + bloom_color * 1.0 + 0.0 * threshold_color;

  //color += (rand(uv.xy + rand(fragCoord.xy * 1.0) + fract(iTime)) * 2.0 - 1.0) * 0.5 / 255.0;

  fragColor = vec4(color, 1.0);
}
