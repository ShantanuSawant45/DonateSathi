class NGO {
  final String id;
  final String name;
  final String location;
  final String cause;
  final String description;
  final String contactPhone;
  final String contactEmail;
  final String imageUrl;

  NGO({
    required this.id,
    required this.name,
    required this.location,
    required this.cause,
    required this.description,
    required this.contactPhone,
    required this.contactEmail,
    required this.imageUrl,
  });

  static List<NGO> getDummyNGOs() {
    return [
      NGO(
        id: '1',
        name: 'Goonj',
        location: 'Delhi',
        cause: 'Disaster Relief & Rural Development',
        description:
            'Goonj works on using urban discard as a resource for rural development. They provide clothing, education material, and other essentials to communities in need across India.',
        contactPhone: '+91 11 4104 1626',
        contactEmail: 'info@goonj.org',
        imageUrl: 'https://via.placeholder.com/150?text=Goonj',
      ),
      NGO(
        id: '2',
        name: 'Akshaya Patra',
        location: 'Bengaluru',
        cause: 'Child Education & Nutrition',
        description:
            'Akshaya Patra implements the Mid-Day Meal Scheme in government schools, serving millions of children across India to fight hunger and support education.',
        contactPhone: '+91 80 2782 0700',
        contactEmail: 'contact@akshayapatra.org',
        imageUrl: 'https://via.placeholder.com/150?text=Akshaya+Patra',
      ),
      NGO(
        id: '3',
        name: 'Pratham',
        location: 'Mumbai',
        cause: 'Education',
        description:
            'Pratham focuses on high-quality, low-cost education programs for underprivileged children, working both in schools and communities to improve learning outcomes.',
        contactPhone: '+91 22 2302 3335',
        contactEmail: 'info@pratham.org',
        imageUrl: 'https://via.placeholder.com/150?text=Pratham',
      ),
      NGO(
        id: '4',
        name: 'CRY - Child Rights and You',
        location: 'Mumbai',
        cause: 'Child Rights',
        description:
            'CRY works to ensure children\'s rights to education, healthcare, protection from exploitation and abuse, and emergency assistance during disasters.',
        contactPhone: '+91 22 2380 6491',
        contactEmail: 'support@cry.org',
        imageUrl: 'https://via.placeholder.com/150?text=CRY',
      ),
      NGO(
        id: '5',
        name: 'HelpAge India',
        location: 'New Delhi',
        cause: 'Elder Care',
        description:
            'HelpAge India works for the welfare of elderly citizens, providing mobile healthcare, elder helplines, and advocating for policies supporting senior citizens.',
        contactPhone: '+91 11 4165 3333',
        contactEmail: 'headoffice@helpageindia.org',
        imageUrl: 'https://via.placeholder.com/150?text=HelpAge+India',
      ),
    ];
  }
}
