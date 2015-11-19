class HeaderSearch extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      tagGroup: new EtherealTagGroup()
    };
  }
  render(){
    return <div>
      <TagGroupEditor
        key={1}
        group={this.state.tagGroup}
        onTagRemove={this.removeTag.bind(this)}
        onTagAdd={this.addTag.bind(this)}
        autofocus={true}
        onSubmit={this.submit.bind(this)}
      />
    </div>;
  }
}

document.addEventListener('page:load', function(){
  console.log("Header Search Event Fires");

});
