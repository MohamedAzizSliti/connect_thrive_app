import 'package:flutter/material.dart';
import 'package:connect_thrive_app/widgets/profile_app_bar.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final List<Map<String, dynamic>> allDoctors = const [
    {
      'name': 'Dr. Amina Benali',
      'specialty': 'Psychologist',
      'rating': 4.8,
      'available': true,
      'experience': '8 years',
      'location': 'Tunis',
      'description': 'Specializing in adolescent mental health and anxiety disorders',
    },
    {
      'name': 'Dr. Karim Mansour',
      'specialty': 'Psychiatrist',
      'rating': 4.9,
      'available': false,
      'experience': '12 years',
      'location': 'Sfax',
      'description': 'Expert in depression and mood disorders treatment',
    },
    {
      'name': 'Dr. Leila Trabelsi',
      'specialty': 'Therapist',
      'rating': 4.7,
      'available': true,
      'experience': '6 years',
      'location': 'Sousse',
      'description': 'Focus on trauma therapy and family counseling',
    },
    {
      'name': 'Dr. Mohamed Amri',
      'specialty': 'Counselor',
      'rating': 4.6,
      'available': true,
      'experience': '10 years',
      'location': 'Tunis',
      'description': 'Specialized in stress management and life coaching',
    },
    {
      'name': 'Dr. Sarah Khelifi',
      'specialty': 'Clinical Psychologist',
      'rating': 4.9,
      'available': true,
      'experience': '15 years',
      'location': 'Bizerte',
      'description': 'Expert in cognitive behavioral therapy for teens',
    },
    {
      'name': 'Dr. Ahmed Gharbi',
      'specialty': 'Mental Health Counselor',
      'rating': 4.5,
      'available': false,
      'experience': '7 years',
      'location': 'Sfax',
      'description': 'Specializes in peer support and group therapy',
    },
  ];

  String _searchQuery = '';
  String _selectedLocation = 'All';
  String _selectedSpecialty = 'All';

  List<Map<String, dynamic>> get filteredDoctors {
    List<Map<String, dynamic>> filtered = allDoctors;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((doctor) {
        return doctor['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               doctor['specialty'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               doctor['description'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by location
    if (_selectedLocation != 'All') {
      filtered = filtered.where((doctor) => doctor['location'] == _selectedLocation).toList();
    }

    // Filter by specialty
    if (_selectedSpecialty != 'All') {
      filtered = filtered.where((doctor) => doctor['specialty'] == _selectedSpecialty).toList();
    }

    return filtered;
  }

  List<String> get locations => ['All', ...allDoctors.map((d) => d['location'] as String).toSet()];
  List<String> get specialties => ['All', ...allDoctors.map((d) => d['specialty'] as String).toSet()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Help'),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: UserAvatar(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search doctors by name, specialty...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        items: locations.map((location) => DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        )).toList(),
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
                        decoration: const InputDecoration(
                          labelText: 'Specialty',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        items: specialties.map((specialty) => DropdownMenuItem(
                          value: specialty,
                          child: Text(specialty),
                        )).toList(),
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
          
          // Results
          Expanded(
            child: filteredDoctors.isEmpty
                ? const Center(
                    child: Text('No doctors found matching your criteria'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildDoctorCard(doctor),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF6366F1).withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF6366F1),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        doctor['specialty'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            doctor['rating'].toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.location_on, color: Color(0xFF64748B), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            doctor['location'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor['experience'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: doctor['available']
                        ? const Color(0xFF10B981)
                        : const Color(0xFF94A3B8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    doctor['available'] ? 'Available' : 'Busy',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              doctor['description'],
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.volunteer_activism, color: Color(0xFF10B981), size: 16),
                const SizedBox(width: 4),
                const Text(
                  'Voluntary Service - Free',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: doctor['available']
                      ? () {
                          // Navigate to booking or chat
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: const Size(0, 0),
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Contact',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
