class Toc {
    Toc({
        required this.chapter,
        required this.sections,
    });

    final String? chapter;
    final List<String> sections;

    Toc copyWith({
        String? chapter,
        List<String>? sections,
    }) {
        return Toc(
            chapter: chapter ?? this.chapter,
            sections: sections ?? this.sections,
        );
    }

    factory Toc.fromJson(Map<String, dynamic> json){ 
        return Toc(
            chapter: json["chapter"],
            sections: json["sections"] == null ? [] : List<String>.from(json["sections"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "chapter": chapter,
        "sections": sections.map((x) => x).toList(),
    };

}
