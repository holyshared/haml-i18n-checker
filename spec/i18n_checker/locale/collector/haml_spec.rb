describe I18nChecker::Locale::Collector::Haml do
  describe '#collect' do
    let(:collector) { I18nChecker::Locale::Collector::Haml.new }
    context 'when has oneline_child element' do
      let(:haml_file) { 'spec/fixtures/haml/oneline_child.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 9
      end
    end
    context 'when has children element' do
      let(:haml_file) { 'spec/fixtures/haml/children.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 10
      end
    end
    context 'when has lazy lookup' do
      let(:haml_file) { 'spec/fixtures/haml/rails/app/views/books/index.html.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(2)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('books.index.title')
        expect(subject[0].line).to be 10
        expect(subject[1].file).to eq(haml_file)
        expect(subject[1].text).to eq('books.index.description')
        expect(subject[1].line).to be 12
      end
    end

    context 'when has same text key' do
      let(:haml_file) { 'spec/fixtures/haml/same_text.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(2)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('user.show.link_label')
        expect(subject[0].line).to be 9
        expect(subject[0].column).to be 18

        expect(subject[1].file).to eq(haml_file)
        expect(subject[1].text).to eq('user.show.link_label')
        expect(subject[1].line).to be 9
        expect(subject[1].column).to be 45
      end
    end

    context 'when has view helper' do
      let(:haml_file) { 'spec/fixtures/haml/call_view_helper.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(3)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('user.show.link_title')
        expect(subject[0].line).to be 9
        expect(subject[0].column).to be 29

        expect(subject[1].file).to eq(haml_file)
        expect(subject[1].text).to eq('user.show.link_label')
        expect(subject[1].line).to be 11
        expect(subject[1].column).to be 18

        expect(subject[2].file).to eq(haml_file)
        expect(subject[2].text).to eq('user.show.link_detail')
        expect(subject[2].line).to be 11
        expect(subject[2].column).to be 45
      end
    end

    context 'when has multiline text key' do
      let(:haml_file) { 'spec/fixtures/haml/multiline.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(1)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('views.pagination.first_html')
        expect(subject[0].line).to be 3
        expect(subject[0].column).to be 7
      end
    end

    context 'when has embedded text key' do
      let(:haml_file) { 'spec/fixtures/haml/embedded.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(1)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('user.index.title')
        expect(subject[0].line).to be 1
        expect(subject[0].column).to be 11
      end
    end

    context 'when has variables' do
      let(:haml_file) { 'spec/fixtures/haml/variables.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(2)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('user.books.index.year')
        expect(subject[0].line).to be 9
        expect(subject[0].column).to be 24

        expect(subject[1].file).to eq(haml_file)
        expect(subject[1].text).to eq('user.books.index.hour')
        expect(subject[1].line).to be 9
        expect(subject[1].column).to be 52
      end
    end

    context 'when has short syntax' do
      let(:haml_file) { 'spec/fixtures/haml/short_syntax.haml' }
      subject { collector.collect(haml_file) }
      it 'should be return locale text' do
        expect(subject.size).to eq(2)
        expect(subject[0].file).to eq(haml_file)
        expect(subject[0].text).to eq('user.books.index.title')
        expect(subject[0].line).to be 9
        expect(subject[0].column).to be 14

        expect(subject[1].file).to eq(haml_file)
        expect(subject[1].text).to eq('user.books.index.message')
        expect(subject[1].line).to be 10
        expect(subject[1].column).to be 13
      end
    end
  end
end
