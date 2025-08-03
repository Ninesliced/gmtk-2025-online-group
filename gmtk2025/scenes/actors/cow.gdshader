shader_type canvas_item;

uniform bool isOutlineEnabled = true;
uniform vec4 outlineColor: source_color;
uniform bool isOutlineSquare = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (!isOutlineEnabled) {
		COLOR = texture(TEXTURE, UV);
	} else {
		float pixel_x = 1.0 / float(textureSize(TEXTURE, 0).x);
		float pixel_y = 1.0 / float(textureSize(TEXTURE, 0).y);
		vec4 colorA = texture(TEXTURE, vec2(UV.x + pixel_x, UV.y));
		vec4 colorB = texture(TEXTURE, vec2(UV.x - pixel_x, UV.y));
		vec4 colorC = texture(TEXTURE, vec2(UV.x, UV.y + pixel_y));
		vec4 colorD = texture(TEXTURE, vec2(UV.x, UV.y - pixel_y));
		float a = max(colorA.a, max(colorB.a, max(colorC.a, max(colorD.a, 0.0))));
		if (isOutlineSquare) {
			vec4 colorE = texture(TEXTURE, vec2(UV.x + pixel_x, UV.y + pixel_y));
			vec4 colorF = texture(TEXTURE, vec2(UV.x - pixel_x, UV.y + pixel_y));
			vec4 colorG = texture(TEXTURE, vec2(UV.x + pixel_x, UV.y - pixel_y));
			vec4 colorH = texture(TEXTURE, vec2(UV.x - pixel_x, UV.y - pixel_y));
			a = max(a, max(colorE.a, max(colorF.a, max(colorG.a, max(colorH.a, 0.0)))));
		}
		
		COLOR = mix(vec4(outlineColor.rgb, a), texture(TEXTURE, UV), texture(TEXTURE, UV).a);
	}
}
