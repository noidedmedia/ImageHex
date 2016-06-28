import EtherealTagGroup from '../../api/ethereal_tag_group.es6';
import TagGroupEditor from './tag_group_editor.es6.jsx';
import Image from '../../api/image.es6';
import NM from '../../api/global.es6';

class ImageTagGroup extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tags: props.initialTags || [],
      showSubmit: true
    };
  }

  render() {
    var submit;
    if (this.state.showSubmit) {
      submit =  <button onClick={this.submit.bind(this)}>
        Submit
      </button>;
    }
    else {
      submit = <div></div>;
    }
    var className = "image-group-editor";
    if (! this.props.groupId ) {
      className += " new-group";
    }
    return <div className={className}>
      <TagGroupEditor
        tags={this.state.tags}
        group={this.state.group}
        onTagAdd={this.addTag.bind(this)}
        onTagRemove={this.removeTag.bind(this)}
        autofocus={true}
        onSubmit={this.submit.bind(this)}
        allowTagCreation={true}
        hideSubmit={this.hideSubmit.bind(this)}
        showSubmit={this.showSubmit.bind(this)}
      />
      {submit}
    </div>;
  }

  hideSubmit() {
    this.setState({
      showSubmit: false
    });
  }
  showSubmit() {
    this.setState({
      showSubmit: true
    });
  }

  addTag(tag) {
    let id = tag.id;
    if(this.state.tags.find(t => t.id === id)) {
      // Tag already exists, do nothing
    }
    else {
      this.setState({
        tags: [...this.state.tags, tag],
        showSubmit: true
      });
    }
  }

  removeTag(tag) {
    this.setState({
      tags: NM.reject(this.state.tags, (t) => t.id === tag.id),
        showSubmit: true
    });
  }

  async submit() {
    if (this.props.groupId) {
      let {imageId, groupId} = this.props;
      var url = `/images/${imageId}/tag_groups/${groupId}`;
      var tag_ids = this.state.tags.map((t) => t.id);
      var data = {
        tag_group: {
          tag_ids: tag_ids
        }
      };
      let d = await NM.putJSON(url, data);
      window.location.reload();
    }
    // new tag group
    else {
      var tag_ids = this.state.tags.map((t) => t.id);
      var data = {
        tag_group: {
          tag_ids: tag_ids
        }
      };
      var url = `/images/${this.props.imageId}/tag_groups`;
      let j = await NM.postJSON(url, data);
      window.location.reload();
    }
  }
}

document.addEventListener("turbolinks:load", function() {
  console.log("Event fires");
  var newButton = document.getElementById("add-tag-group-button");
  if (newButton) {
    newButton.addEventListener("click", function() {
      ReactDOM.render(<ImageTagGroup 
        isNew={true}
        imageId={this.dataset.image_id}
      />, this.parentElement);
    });
  }
  var elements = document.getElementsByClassName("edit-generic-tag-group");
  for (var e = 0; e < elements.length; e++) {
    var element = elements[e];
    element.addEventListener("click", async function() {
      let imgId = this.dataset.image_id;
      let groupId = this.dataset.group_id;
      let img = await NM.getJSON(`/images/${imgId}.json`);
      console.log("Got image data", img);
      console.log("Group id is", groupId);
      let group = img.tag_groups.find((g) => g.id == groupId);
      ReactDOM.render(<ImageTagGroup
        initialTags={group.tags}
        groupId={groupId}
        imageId={imgId}
        isNew={false} />, this.parentElement);
    }.bind(element));
  }
});

document.addEventListener("turbolinks:before-render", function() {
  $(".image-group-editor").toArray().forEach(o => {
    ReactDOM.unmountComponentAtNode(o.parentNode);
  });
});
