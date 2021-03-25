void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 forest_color = texture(iChannel0, vec2(uv.x, uv.y)).rgb;
  vec3 bloom_color = 1.0 * texture(iChannel1, uv).rgb;

  vec3 color = forest_color + bloom_color;

  fragColor = vec4(color, 1.0);
}
