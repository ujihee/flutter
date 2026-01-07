/*
  날짜 : 2025/12/15
  내용 : 약관 페이지 추가 (토스 스타일 UI 통일)
  작성자 : 오서정
  수정: 2025/01/04 - UI 수정 - 작성자: 오서정
*/
import 'package:flutter/material.dart';
import 'package:tkbank/models/term.dart';
import 'package:tkbank/screens/member/register/phone_verify_screen.dart';
import 'package:tkbank/services/member_service.dart';
import 'package:tkbank/widgets/register_step_indicator.dart';
import 'term_webview_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final MemberService _memberService = MemberService();
  late Future<List<Term>> _termsFuture;

  final Map<int, bool> _agreeMap = {};
  bool _allChecked = false;

  static const Color primaryPurple = Color(0xFF6A1B9A);

  @override
  void initState() {
    super.initState();
    _termsFuture = _memberService.fetchTerms();
  }

  void _openTerm(int termNo) {
    final url = 'http://10.0.2.2:8080/busanbank/member/term/$termNo';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TermWebViewScreen(url: url),
      ),
    );
  }

  void _updateAllChecked() {
    _allChecked = _agreeMap.values.every((v) => v == true);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ✅ 하단 버튼 (다음 단계)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _allChecked
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PhoneVerifyScreen(),
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPurple,
              disabledBackgroundColor: primaryPurple.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              '다음',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: FutureBuilder<List<Term>>(
          future: _termsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('약관 정보를 불러올 수 없습니다.'));
            }

            // 2026/01/03 - 약관 출력 수정 - 작성자: 오서정
            final all = snapshot.data!;
            final terms = all.where((t) => t.termType == '01' || t.termType == '02').toList();

            for (var term in terms) {
              _agreeMap.putIfAbsent(term.termNo, () => false);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔙 뒤로가기
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegisterStepIndicator(step: 1),
                      const SizedBox(height: 32),

                      const Text(
                        '회원가입을 위해',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        '필요한 사항을 확인해 주세요.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '서비스 이용을 위해 약관에 동의해주세요',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// ✅ 전체 동의
                      _card(
                        child: CheckboxListTile(
                          value: _allChecked,
                          activeColor: primaryPurple,
                          onChanged: (value) {
                            setState(() {
                              _allChecked = value ?? false;
                              for (var term in terms) {
                                _agreeMap[term.termNo] = _allChecked;
                              }
                            });
                          },
                          title: const Text(
                            '약관 전체 동의',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// ✅ 개별 약관 리스트
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                    itemCount: terms.length,
                    itemBuilder: (context, index) {
                      final term = terms[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _card(
                          child: InkWell(
                            onTap: () => _openTerm(term.termNo),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _agreeMap[term.termNo],
                                  activeColor: primaryPurple,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreeMap[term.termNo] = value ?? false;
                                      _updateAllChecked();
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    term.termTitle,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
