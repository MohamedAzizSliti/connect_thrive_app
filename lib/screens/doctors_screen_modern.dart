import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialty;
  final String location;
  final String phone;
  final String email;
  final double rating;
  final String imageUrl;
  final String description;
  final List<String> specialties;

  Doctor({
    required this.name,
    required this.specialty,
    required this.location,
    required this.phone,
    required this.email,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.specialties,
  });
}

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  String _selectedLocation = 'All';
  String _selectedSpecialty = 'All';

  final List<Doctor> tunisianDoctors = [
    // Southern Tunisia
    Doctor(
      name: 'Dr. Amine Ben Amor',
      specialty: 'Psychiatre',
      location: 'Gafsa',
      phone: '+216 76 210 123',
      email: 'dr.benamor.gafsa@clinic.tn',
      rating: 4.8,
      imageUrl: '',
      description: 'Spécialiste en santé mentale avec 15 ans d\'expérience.',
      specialties: ['Dépression', 'Anxiété', 'Troubles bipolaires'],
    ),
    Doctor(
      name: 'Dr. Fatma Trabelsi',
      specialty: 'Psychologue',
      location: 'Tozeur',
      phone: '+216 76 460 456',
      email: 'dr.trabelsi.tozeur@clinic.tn',
      rating: 4.7,
      imageUrl: '',
      description: 'Psychologue clinicienne spécialisée en thérapie cognitive.',
      specialties: ['Thérapie individuelle', 'Troubles anxieux', 'Dépression'],
    ),
    Doctor(
      name: 'Dr. Khaled Bouzid',
      specialty: 'Psychiatre',
      location: 'Tataouine',
      phone: '+216 75 470 789',
      email: 'dr.bouzid.tataouine@clinic.tn',
      rating: 4.6,
      imageUrl: '',
      description: 'Expert en troubles de l\'humeur et en psychothérapie.',
      specialties: ['Troubles de l\'humeur', 'Psychothérapie', 'Addiction'],
    ),
    
    // North-West Tunisia
    Doctor(
      name: 'Dr. Leila Jendoubi',
      specialty: 'Psychiatre',
      location: 'Jendouba',
      phone: '+216 78 610 234',
      email: 'dr.jendoubi.jendouba@clinic.tn',
      rating: 4.9,
      imageUrl: '',
      description: 'Médecin psychiatre avec expertise en santé mentale communautaire.',
      specialties: ['Santé mentale communautaire', 'Psychiatrie sociale'],
    ),
    Doctor(
      name: 'Dr. Mohamed Béjaoui',
      specialty: 'Psychologue',
      location: 'Béja',
      phone: '+216 78 450 567',
      email: 'dr.bejaoui.beja@clinic.tn',
      rating: 4.7,
      imageUrl: '',
      description: 'Psychologue spécialisé en thérapie familiale et conjugale.',
      specialties: ['Thérapie familiale', 'Thérapie de couple', 'Médiation'],
    ),
    Doctor(
      name: 'Dr. Samira Sili',
      specialty: 'Psychiatre',
      location: 'Siliana',
      phone: '+216 78 320 890',
      email: 'dr.sili.siliana@clinic.tn',
      rating: 4.8,
      imageUrl: '',
      description: 'Spécialiste en psychiatrie de l\'enfant et de l\'adolescent.',
      specialties: ['Psychiatrie infantile', 'TDAH', 'Autisme'],
    ),
    Doctor(
      name: 'Dr. Rachid Kefi',
      specialty: 'Psychiatre',
      location: 'Le Kef',
      phone: '+216 78 280 123',
      email: 'dr.kefi.kef@clinic.tn',
      rating: 4.6,
      imageUrl: '',
      description: 'Expert en troubles anxieux et en thérapies comportementales.',
      specialties: ['Anxiété', 'TOC', 'Thérapies comportementales'],
    ),
    
    // Central Tunisia
    Doctor(
      name: 'Dr. Amira Mahfoudh',
      specialty: 'Psychiatre',
      location: 'Kasserine',
      phone: '+216 77 410 456',
      email: 'dr.mahfoudh.kasserine@clinic.tn',
      rating: 4.7,
      imageUrl: '',
      description: 'Psychiatre généraliste avec focus sur la santé mentale rurale.',
      specialties: ['Psychiatrie générale', 'Santé mentale rurale'],
    ),
    
    // East Coast
    Doctor(
      name: 'Dr. Nabil Mahmoud',
      specialty: 'Psychiatre',
      location: 'Mahdia',
      phone: '+216 73 450 789',
      email: 'dr.mahmoud.mahdia@clinic.tn',
      rating: 4.8,
      imageUrl: '',
      description: 'Spécialiste en troubles de l\'humeur et en psychothérapie.',
      specialties: ['Dépression', 'Troubles bipolaires', 'Psychothérapie'],
    ),
    
    // Greater Tunis Area
    Doctor(
      name: 'Dr. Yasmine Ben Salem',
      specialty: 'Psychiatre',
      location: 'Tunis',
      phone: '+216 71 890 123',
      email: 'dr.bensalem.tunis@clinic.tn',
      rating: 4.9,
      imageUrl: '',
      description: 'Psychiatre renommée avec 20 ans d\'expérience en santé mentale.',
      specialties: ['Psychiatrie générale', 'Thérapies avancées', 'Recherche'],
    ),
    Doctor(
      name: 'Dr. Karim Arous',
      specialty: 'Psychologue',
      location: 'Ariana',
      phone: '+216 71 750 456',
      email: 'dr.arous.ariana@clinic.tn',
      rating: 4.8,
      imageUrl: '',
      description: 'Psychologue clinicien spécialisé en thérapie cognitive-comportementale.',
      specialties: ['TCC', 'Anxiété', 'Dépression', 'Thérapie de groupe'],
    ),
    Doctor(
      name: 'Dr. Salma Nasri',
      specialty: 'Psychiatre',
      location: 'La Goulette',
      phone: '+216 71 560 789',
      email: 'dr.nasri.goulette@clinic.tn',
      rating: 4.7,
      imageUrl: '',
      description: 'Expert en psychiatrie périnatale et santé mentale des femmes.',
      specialties: ['Santé mentale féminine', 'Périnatal', 'Post-partum'],
    ),
    
    // Additional Tunisian doctors
    Doctor(
      name: 'Dr. Moncef Ben Ali',
      specialty: 'Psychiatre',
      location: 'Sfax',
      phone: '+216 74 220 123',
      email: 'dr.benali.sfax@clinic.tn',
      rating: 4.6,
      imageUrl: '',
      description: 'Psychiatre avec expertise en santé mentale au travail.',
      specialties: ['Santé mentale professionnelle', 'Burn-out', 'Stress'],
    ),
    Doctor(
      name: 'Dr. Houda Trigui',
      specialty: 'Psychologue',
      location: 'Sousse',
      phone: '+216 73 220 456',
      email: 'dr.trigui.sousse@clinic.tn',
      rating: 4.8,
      imageUrl: '',
      description: 'Psychologue spécialisée en thérapie EMDR et trauma.',
      specialties: ['EMDR', 'Trauma', 'Anxiété', 'Dépression'],
    ),
  ];

  List<String> get locations => ['All', ...tunisianDoctors.map((d) => d.location).toSet()];
  List<String> get specialties => ['All', ...tunisianDoctors.map((d) => d.specialty).toSet()];

  List<Doctor> get filteredDoctors {
    return tunisianDoctors.where((doctor) {
      final matchesLocation = _selectedLocation == 'All' || doctor.location == _selectedLocation;
      final matchesSpecialty = _selectedSpecialty == 'All' || doctor.specialty == _selectedSpecialty;
      return matchesLocation && matchesSpecialty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Tunisian Mental Health Professionals',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLocation = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedSpecialty,
                        decoration: InputDecoration(
                          labelText: 'Specialty',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: specialties.map((specialty) {
                          return DropdownMenuItem(
                            value: specialty,
                            child: Text(specialty),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSpecialty = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: filteredDoctors.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                return _buildModernDoctorCard(filteredDoctors[index]);
              },
            ),
    );
  }

  Widget _buildModernDoctorCard(Doctor doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue.shade800,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        doctor.specialty,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.rating.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  doctor.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              doctor.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: doctor.specialties.map((specialty) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    specialty,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _makePhoneCall(doctor.phone),
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue.shade800,
                      side: BorderSide(color: Colors.blue.shade800),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _sendEmail(doctor.email),
                    icon: const Icon(Icons.email, size: 16),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUri.toString();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone: $e')),
      );
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      await launchUri.toString();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch email: $e')),
      );
    }
  }
}
